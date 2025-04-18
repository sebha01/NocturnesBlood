/*
	Code for Nocturnes Blood

	Controller layout 

	Button	|  Bit Value |	neslib Macro
	A		|	0x80	 |	PAD_A
	B		|	0x40	 |	PAD_B
	Select	|	0x20	 |	PAD_SELECT
	Start	|	0x10	 |	PAD_START
	Up		|	0x08	 |	PAD_UP
	Down	|	0x04	 |	PAD_DOWN
	Left	|	0x02	 |	PAD_LEFT
	Right	|	0x01	 |	PAD_RIGHT

	Z        ← A Button  
	X        ← B Button  
	Enter    ← Start  
	Right Shift or Tab  ← Select  
	↑ Arrow  ← Up  
	↓ Arrow  ← Down  
	← Arrow  ← Left  
	→ Arrow  ← Right  

	pad_poll(0) -> reads current state of controller
	pad_trigger(0) -> returns button once first pressed not held
	pad_state(0) -> gives you last read value from pad_poll, useful if polled earlier in frame and want to refer to it later

--------------------------------------------------------------------------
	Add a Simple Pause Menu IDEA
	c
	if (game_state == STATE_GAME && (pad_trigger(0) & PAD_START)) 
	{
		game_state = STATE_PAUSED;
		// draw pause screen
	}
	And later:

	c
	if (game_state == STATE_PAUSED && (pad_trigger(0) & PAD_START)) 
	{
		game_state = STATE_GAME;
		// resume gameplay
	}

*/	
 
#include "LIB/neslib.h"
#include "LIB/nesdoug.h" 
#include "NES_ST/Level1Data.h"
#include "NES_ST/Level2Data.h"
#include "NES_ST/Level3Data.h"
#include <stdlib.h>
#include "NES_ST/Level1A.h"
#include "NES_ST/Level1B.h"
#include "NES_ST/Level2A.h"
#include "NES_ST/Level2B.h"
#include "NES_ST/Level3A.h"
#include "NES_ST/Level3B.h"

//Define colours
#define BLACK 			0x0f
#define DK_GY 			0x00
#define LT_GY 			0x10
#define WHITE 			0x30
//Blues
#define DK_BLUE  		0x01
#define BLUE     		0x11
#define LT_BLUE     	0x21
#define SKY_BLUE     	0x31
// Greens
#define DK_GREEN     	0x09
#define GREEN        	0x19
#define LT_GREEN     	0x29
#define MINT         	0x39
// Reds
#define DK_RED       	0x05
#define RED          	0x16
#define LT_RED       	0x27
#define PINK         	0x36

//define game states
#define START_SCREEN 0
#define GAME_LOOP 1
#define END_SCREEN 2
//define constants used for player movement
//Movement
#define PLAYER_SPEED 2
//Jumping
#define GRAVITY 1
#define JUMP_VELOCITY -10
#define MAX_FALL_SPEED 4
//dashing
#define DASH_SPEED 5
#define DASH_DURATION 6
#define DASH_COOLDOWN 20
//Scrolling
#define MAX_SCROLL 256
#define MIN_SCROLL 0

#pragma bss-name(push, "ZEROPAGE")

//palette colours
const unsigned char palette[]=
{
	BLACK, DK_GY, LT_GY, WHITE,       
	BLACK, DK_BLUE, BLUE, SKY_BLUE,  
	BLACK, DK_RED, RED, LT_RED,        
	BLACK, DK_GREEN, GREEN, LT_GREEN 
};  

//Possible use for later
const unsigned char spritePalette[] =
{
	BLACK, DK_GY, LT_GY, WHITE, 
	BLACK, DK_BLUE, BLUE, LT_BLUE,  
	BLACK, DK_RED, RED, PINK,
	BLACK, DK_GREEN, GREEN, MINT
};

// GLOBAL VARIABLES
//Defines which state the game is currently in (START_SCREEN, GAME_LOOP or END_SCREEN)
unsigned char currentGameState = START_SCREEN;
//Text
const unsigned char text[] = "Nocturnes Blood"; 
const unsigned char titlePrompt[] = "Press START";
const unsigned char endScreenTitle[] = "End Screen";
const unsigned char endScreenPrompt[] = "To play again";
//variable for getting input from controller
unsigned char inputPad;
unsigned char movementPad;
//Player variables
signed int playerX = 30;
signed int playerY = 215;
//Player x can move first 128 and last 128 pixels without screen moving
//Scroll x comes in to make sure the screen moves when the player does
unsigned int scrollX = 0;
char facingRight = 1;
//jumping variables 
int velocityY = 0;
char isJumping = 0;
//Dash variables 
unsigned int isDashing = 0;
char dashTimer = 0;
char dashCooldown = 0;
char hasDashedInAir = 0;
// -1 = left, 1 = right
signed int dashDirection = 0; 
//other variables
int i = 0;
//lowest 1 highest 3
int currentLevel = 1;
const unsigned char* currentLevelData;


//function prototypes
void DrawTitleScreen(void);
void GameLoop(void);
void Fade(void);
void MovePlayer(void);
void DrawPlayer(void);
unsigned int GetTileIndex(unsigned char playerX, unsigned char playerY);
void CheckIfEnd(void);
void DrawEndScreen(void);
char OnGround(void); 
char checkIfCollidableTile(unsigned char tile);
void HandleRightMovement(unsigned int bound, unsigned int amountToIncrement);
void HandleLeftMovement(unsigned int bound, unsigned int amountToDecrement);
char checkIfGoalTile(unsigned char tile); 

/*
----------------
-- -- MAIN -- --
----------------
*/

void main (void) 
{
	DrawTitleScreen();

	// infinite loop
	while (1)
	{
		//Waits for next frame
		ppu_wait_nmi();
		movementPad = pad_poll(0);
		inputPad = get_pad_new(0);

		switch(currentGameState)
		{
			case START_SCREEN:
				//Check if player has pressed start
				if (inputPad & PAD_START)
				{
					currentGameState = GAME_LOOP;
					GameLoop();
				}
				break;
			case GAME_LOOP:
				//Player code
				MovePlayer();
				DrawPlayer();
				scroll(scrollX, 0);
				//Check if player has reached end goal
				CheckIfEnd();
				break;
			case END_SCREEN:
				//Check if player has pressed start
				if (inputPad & PAD_START)
				{
					currentGameState = START_SCREEN;
					DrawTitleScreen();
				}
				break;
		}
	}
}
	
/*
---------------------------
-- -- OTHER FUNCTIONS -- --
---------------------------
*/

void DrawTitleScreen(void)
{
	ppu_off(); // screen off
	pal_bg(palette); //	load the BG palette
	// vram_adr and vram_put only work with screen off NOTE, you could replace everything between i = 0; and here with...
	// vram_write(text,sizeof(text)); does the same thing
	//Set VRAM address to row 10 and column 12
	vram_adr(NTADR_A(8, 8)); // places text at screen position
	vram_write(text, sizeof(text) - 1); //write Title to screen
	//Write prompt to start game
	vram_adr(NTADR_A(10, 14));
	vram_write(titlePrompt, sizeof(titlePrompt) - 1);
	
	ppu_on_all(); //	turn on screen
}

void GameLoop(void)
{
	//Turn screen off
	ppu_off(); 

	switch(currentLevel)
	{
		case 1:
			currentLevelData = Level1Data;
			// Write the new level data
			vram_adr(NAMETABLE_A);   // Set VRAM address to the top-left of the screen
			vram_write(Level1A, 1024);

			vram_adr(NAMETABLE_B);   // Set VRAM address to the top-left of the screen
			vram_write(Level1B, 1024);
			break;
		case 2:
			currentLevelData = Level2Data;
			// Write the new level data
			vram_adr(NAMETABLE_A);
			vram_write(Level2A, 1024);

			vram_adr(NAMETABLE_B);
			vram_write(Level2B, 1024);
			break;
		case 3:
			currentLevelData = Level3Data;
			// Write the new level data
			vram_adr(NAMETABLE_A);
			vram_write(Level3A, 1024);

			vram_adr(NAMETABLE_B);
			vram_write(Level3B, 1024);
			break;
	}

	//Load palette
	pal_bg(palette);
	pal_spr((const char*)spritePalette);

	ppu_on_all();
}

void MovePlayer(void)
{
	//-------------------------
    // Horizontal movement
	//-------------------------
	//left
    if (movementPad & PAD_LEFT)
    {
        if (!checkIfCollidableTile(currentLevelData[GetTileIndex(playerX - 1, playerY + 1)]))
        {
			//Handle movement
			HandleLeftMovement(4, PLAYER_SPEED);
			//Set facing right to false
			facingRight = 0;
        }
    }

	//Right
    if (movementPad & PAD_RIGHT)
    {
        if (!checkIfCollidableTile(currentLevelData[GetTileIndex(playerX + 8, playerY + 1)]))
        {
			//Handle Movement
			HandleRightMovement(252, PLAYER_SPEED);
			//Set facing right to true
			facingRight = 1;
        }
    }

    // Dash mechanic
	//Checks if B pressed, the player is not dashing and the dashCoolDown has not been activated
	if ((inputPad & PAD_B) && !isDashing && dashCooldown == 0) 
	{
		// Only allow midair dash if the player has not dashed in the air yet
		if (OnGround() || !hasDashedInAir)
		{
			dashDirection = (movementPad & PAD_LEFT ? -1 : movementPad & PAD_RIGHT ? 1 : 0);
			isDashing = 1;
			dashTimer = DASH_DURATION;

			//Makes sure no double air dashing
			if (!OnGround())
			{
				hasDashedInAir = 1;
			}
		}
	}

	//-------------------------
	//Dash mechanic
	//-------------------------
	if (isDashing) 
	{
		//Checks each pixel individually to make sure it doesn't let the player phase through collidables
		for (i = 0; i < DASH_SPEED; i++) 
		{
			//Calculates the next X position depending on direction
			int nextX = playerX + dashDirection;
			//Make sure checkX is correct for collision checking
			//If direction is right then 7 pixels will be added on to account for the width of the player
			//If left then nothing will be added on as already checking in to the left
			int checkX = nextX + scrollX + (dashDirection == 1 ? 7 : 0);

			//Check that there is not a collidable and if there is not then the player can move
			if (!checkIfCollidableTile(currentLevelData[GetTileIndex(checkX, playerY + 1)])) 
			{
				
				if (dashDirection == 1) 
				{
					//Dash direction is right
					HandleRightMovement(255, 1);
				} 
				else if (dashDirection == -1)
				{
					//Dash direction is left
					HandleLeftMovement(1, 1);
				}
				else
				{
					//Disable dash if player is not holding left or right to dash
					isDashing = 0;
					dashCooldown = DASH_COOLDOWN;
				}
			} 
			else 
			{
				//If a collidable is hit then the dash will end early and the dash cool down starts
				isDashing = 0;
				dashCooldown = DASH_COOLDOWN;
			}
		}

		//Decrement the dash timer so that when it runs out player stops dashing
		dashTimer--;

		//When the timer runs out isDashing bool is set to false and cooldown begins
		if (dashTimer <= 0) 
		{
			isDashing = 0;
			dashCooldown = dashCooldown;
		}
	}
    else 
    {
        // ----------------------------
		// Jumping mechanic only runs if player is not dashing on the ground
		// ----------------------------

		// Check if jump button (A) is pressed, player is not already jumping, and player is currently standing on solid ground
        if ((inputPad & PAD_A) && !isJumping && OnGround()) 
        {
			//Set the "bool" variable to true
            isJumping = 1;
			//Set the velocity to be the constant we defined applies an upward force to the player by being a negative value
            velocityY = JUMP_VELOCITY;
        }

		//Checks for if the player is jumping
        if (isJumping) 
        {
			//Apply gravity to bring the player back down
            velocityY += GRAVITY;
			//makeSure hte fall speed doesn't exceed the max value so player doesn't fall too fast
            if (velocityY > MAX_FALL_SPEED)
			{
                velocityY = MAX_FALL_SPEED;
			}
			//Move the player depending on the value of the velocity velocity starts off negative so it acts as an upwards force
			//As it becomes positive it becomes a downward force to pull the player back
            playerY += velocityY;
			//Checks to see if player is stil falling but on the ground
            if (velocityY >= 0 && OnGround()) 
            {
				//makes sure that the player doesn't go into the collidable tile
                while (OnGround()) 
				{
					playerY -= 1;
				}
				//Reset all variables to do with jumping and dashing now that the player is on the ground
				//Also make sure that the player is at ground level so the player is not floating slightly
                playerY += 1;
                velocityY = 0;
                isJumping = 0;
				hasDashedInAir = 0;
            }
        } 
        else 
        {
			//More of a just in case the player is not on the ground but the value for isJumping is not set to true
			//So it gets set to 1 so gravity can bring the player back down
            if (!OnGround()) 
            {
                isJumping = 1;
            }
        }
    }

    // Dash cooldown. begin counting down if dash has finished the time until player can dash again
    if (dashCooldown > 0) 
	{
        dashCooldown--;
    }
}

void DrawPlayer(void)
{
	unsigned char playerAttributes = 0x01;

	if (!facingRight)
	{
		playerAttributes |= 0x40;
	}

	//Clears all sprite entries in Object Attribute Memory OAM special memopry area that holds info about sprites
	//Such as pos, tile index, palette etc.
	oam_clear();
	
	if (isDashing)
	{
		oam_spr(playerX, playerY - 8, 0x09, playerAttributes);
    	oam_spr(playerX, playerY, 0x19, playerAttributes);
	}
	else if (isJumping)
	{
		oam_spr(playerX, playerY - 8, 0x0A, playerAttributes);
    	oam_spr(playerX, playerY, 0x1A, playerAttributes);
	}
	else
	{
		// Draw the player using two tiles: 0x08 (top), 0x24 (bottom)
		oam_spr(playerX, playerY - 8, 0x08, playerAttributes);
		oam_spr(playerX, playerY, 0x18, playerAttributes);
	}
}

unsigned int GetTileIndex(unsigned char playerX, unsigned char playerY)
{
    // Get the x and y tile that the player is currently on Divide by 8 as the players current position is in
	// pixels. Each tile has 8 pixels so we need to divide by 8 to find the tile We need to add scrollX to it 
	//so that we can find the correct position across both halves of the map
    unsigned char tileX = (playerX + scrollX) / 8; 
    unsigned char tileY = playerY / 8;
    // As we play in a 64x30 map to first find the correct y position We multiply by 64 to get the correct row
	//Then we add tileX to find the column and the index of the tile
    unsigned int tileIndex = tileY * 64 + tileX;

    return tileIndex;
}

void CheckIfEnd()
{
	if (checkIfGoalTile(currentLevelData[GetTileIndex(playerX, playerY + 9)]) || 
	checkIfGoalTile(currentLevelData[GetTileIndex(playerX + 1, playerY + 1)]) ||
	checkIfGoalTile(currentLevelData[GetTileIndex(playerX + 6, playerY + 1)]))
	{
		if (currentLevel == 3)
		{
			scrollX = 0;
			scroll(scrollX, 0);
			playerX = 30;
			playerY = 215;
			currentGameState = END_SCREEN;
			DrawEndScreen();
		}
		else
		{
			currentLevel++;
			
			scrollX = 0;
			playerX = 30;
			playerY = 215;

			GameLoop();
		}
	}
}

void DrawEndScreen()
{
	ppu_off(); // screen off
	pal_bg(palette); //	load the BG palette

	//Clear all sprite data
	oam_clear();

	//Set varirables back to their default value
	currentLevel = 1;

	//Clear the screen
	vram_adr(NAMETABLE_A);            // Set VRAM address to start of screen
	vram_fill(0x00, 1024);

	//Clear the screen
	vram_adr(NAMETABLE_B);            // Set VRAM address to start of screen
	vram_fill(0x00, 1024);

	vram_adr(NTADR_A(8, 8)); // places text at screen position
	vram_write(endScreenTitle, sizeof(endScreenTitle) - 1); //write Title to screen
	//Write prompt to start game
	vram_adr(NTADR_A(10, 14));
	vram_write(titlePrompt, sizeof(titlePrompt) - 1);

	vram_adr(NTADR_A(10, 18));
	vram_write(endScreenPrompt, sizeof(endScreenPrompt) - 1);

	ppu_on_all(); //	turn on screen
}

char OnGround(void) 
{
    return checkIfCollidableTile(currentLevelData[GetTileIndex(playerX, playerY + 9)]);
}

char checkIfCollidableTile(unsigned char tile) 
{
	//Stores all of the tiles that are collidable and is used to calculate collisions
    return tile == 0x80 || tile == 0x81 || tile == 0x82 || tile == 0x83 
		|| tile == 0x90 || tile == 0x91 || tile == 0x92 || tile == 0x93;
}

void HandleRightMovement(unsigned int bound, unsigned int amountToIncrement)
{
	//Make sure player x is 0 - 128 and player X and scrollX is 384 or greater
	//before we increment playerX
	if (playerX > 0 && playerX < 128 || (playerX + scrollX >= 384))
	{
		playerX += amountToIncrement;
	}
	// Make sure playerX and scrollX is greater than 128 and less than 384
	//before incrementing scrollX
	else if ((playerX + scrollX) >= 128 && (playerX + scrollX) < 384)
	{
		//Makes sure ScrollX goes up to 256 only
		if (scrollX <= bound) 
		{
			scrollX += amountToIncrement;
		} 
		else 
		{
			//prevents scrollX from going above 256 in the odd case it does
			scrollX = MAX_SCROLL;
		}
	}
}


void HandleLeftMovement(unsigned int bound, unsigned int amountToDecrement)
{
	 //Make sure player x is 0 - 128 and player X and scrollX is 384 or greater
	//before we decrement playerX
	if (playerX > 0 && playerX < 128 || (playerX + scrollX > 384) || 
	(scrollX == MIN_SCROLL))
	{
		playerX -= amountToDecrement;
	}
	// Make sure playerX and scrollX is greater than 128 and less than 384
	//before decrementing scrollX
	else if ((playerX + scrollX) > 128 && (playerX + scrollX) <= 384)
	{
		//Makes sure ScrollX goes down to 0 only
		if (scrollX >= bound) 
		{
			scrollX -= amountToDecrement;
		} 
		else 
		{
			//prevents scrollX from going negative in the odd case it does
			scrollX = MIN_SCROLL;
		}
	} 
}

char checkIfGoalTile(unsigned char tile) 
{
	//Stores all of the tiles that are collidable and is used to calculate collisions
    return tile == 0x06 || tile == 0x07 || tile == 0x16 || tile == 0x17;
}
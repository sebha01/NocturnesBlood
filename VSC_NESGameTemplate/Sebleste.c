/*
	Welcome to the code for Sebleste, a 2d Platformer with inspiration taken from 
	Celeste, there are 3 levels, the player moves left or right, jumps and dashes.
*/	
 
#include "LIB/neslib.h"
#include "LIB/nesdoug.h" 
#include <stdlib.h>
#include <stdio.h>
#include "NES_ST/LevelData.h"
#include "NES_ST/MenuData.h"


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

//define game states for controlling the game loop
#define START_SCREEN 0
#define GAME_LOOP 1
#define END_SCREEN 2
#define CREDITS_SCREEN 3
//Player Movement
#define PLAYER_SPEED 2
//Player jump constants
#define GRAVITY 1
#define JUMP_VELOCITY -10
#define MAX_FALL_SPEED 4
#define COYOTE_FRAMES  6
#define JUMP_BUFFER_FRAMES 10
//player dash constants
#define DASH_SPEED 5
#define DASH_DURATION 6
#define DASH_COOLDOWN 30
//Health constants
#define LEVEL_COOLDOWN = 90
#define DAMAGE_TIMER 20
//Audio constants
#define MAX_MUSIC_SPEED 12
#define MIN_MUSIC_SPEED 0

#pragma bss-name(push, "ZEROPAGE")

//background palette colours using the colours defined above
const unsigned char palette[]=
{
	BLACK, DK_GY, LT_GY, WHITE,       
	BLACK, DK_BLUE, BLUE, SKY_BLUE,  
	BLACK, DK_RED, RED, LT_RED,        
	BLACK, DK_GREEN, GREEN, LT_GREEN 
};  

// Sprite palette 
const unsigned char spritePalette[] =
{
	BLACK, DK_GY, LT_GY, WHITE, 
	BLACK, DK_BLUE, BLUE, LT_BLUE,  
	BLACK, DK_RED, RED, PINK,
	BLACK, DK_GREEN, GREEN, MINT
};

// GLOBAL VARIABLES
//Sets which state the game loop is currently at
unsigned char currentGameState = START_SCREEN;
//Text
//Title Text
const unsigned char title[] = "SEBLESTE"; 
const unsigned char titlePrompt[] = "Press START to play";
const unsigned char titlePrompt2[] = "Press START";
const unsigned char creditsPrompt[] = "Press SELECT for credits";
//Credits screen text
const unsigned char creditsTitle[] = "Credits";
const unsigned char startScreenPrompt[] = "Press SELECT to return to start";
const unsigned char credits1[] = "Developer - Sebastian Ha";
const unsigned char credits2[] = "Art";
const unsigned char credits3[] = "Character - PixelFight";
const unsigned char credits4[] = "Map - Hexany Tiles";
const unsigned char credits5[] = "Music";
const unsigned char credits6[] = "Famitracker Demo Songs";
const unsigned char credits7[] = "Fami Studio Demo Songs";
//End screen text
const unsigned char endScreenTitle[] = "YOU WON!";
const unsigned char endScreenPrompt[] = "To play again";
//Loading text
const unsigned char loadingText[] = "LOADING :D";
const unsigned char respawningText[] = "RESPAWNING :)";
//Death counter text
const unsigned char DeathCounter[] = "Death Counter";
//variables for getting input from controller
//Gets input from button presses
unsigned char inputPad;
//Gets input for player movement
unsigned char movementPad;
//other variables for controlling for loops 
int i = 0;
//lowest level is 1 and the highest 3
int currentLevel = 1;
//Pointer to use for getting the current level data
const unsigned char* currentLevelData;
//Variable for storing the current death counter
char deathCounterText[6];

//Structure used for the player
typedef struct
{
	//Position variables
	unsigned char x;
	unsigned char y;
	//Coyote time to forgive the player for mistimed jumps
	char coyoteTime;
	//Collider variables
	signed int left;
	signed int right;
	signed int top;
	signed int bottom;
	//Boolean to control direction sprites are facing when drawn
	char facingRight;
	//jumping variables 
	int velocityY;
	char isJumping;
	char jumpBufferTimer;
	//Dash variables 
	unsigned int isDashing;
	char dashTimer;
	char dashCooldown;
	char hasDashedInAir;
	// -1 = left, 1 = right
	signed int dashDirection; 
	//Damage and death variables
	unsigned int deathCounter;
	unsigned int damageTimer;
} Player;

//Player object
Player player;

//function prototypes
//Functions for drawing menu screens or resetting level
void DrawTitleScreen(void);
void DrawCreditsScreen(void);
void DrawEndScreen(void);
void DrawDeathScreen(void);
void ResetLevel(void);
//Game loop function
void GameLoop(void);
// Player functions
void MovePlayer(void);
void DrawPlayer(void);
void UpdateColliderPositions(void);
void DashEnd(void);
void SetPlayerValues(void);
//Check functions for tile ID's, if player on ground or platform or spikes
unsigned int GetTileIndex(unsigned char playerX, unsigned char playerY);
void CheckIfEnd(void);
char OnGround(void); 
char CheckIfCollidableTile(unsigned char tile);
char CheckIfGoalTile(unsigned char tile); 
char CheckIfPlatformTile(unsigned char tile);
char CheckIfSpikes(unsigned char tile);
//Miscellaneous functions
void WriteDeathCounter(void);
void ChangeMusic(unsigned int trackToChangeTo);

/*
----------------
-- -- MAIN -- --
----------------
*/

void main (void) 
{
	//Set the player object values so they spawn in right position
	SetPlayerValues();
	// Make sure to draw the title screen so player sees this when Sebleste loaded
	DrawTitleScreen();

	//0 - 4
	//3 -> title screen, 0 -> level 3, 2 -> win screen, 1 -> level 2, 4 -> level 1
	music_play(3);

	// infinite loop
	while (1)
	{
		//Waits for next frame
		ppu_wait_nmi();
		//Set both movement variables to recieve input
		movementPad = pad_poll(0);
		inputPad = get_pad_new(0);

		//Switch statement to control game loop and which sections appear on screen
		switch(currentGameState)
		{
			case START_SCREEN:
				//Check if player has pressed start
				if (inputPad & PAD_START)
				{
					currentGameState = GAME_LOOP;
					GameLoop();
				}
				else if (inputPad & PAD_SELECT)
				{
					currentGameState = CREDITS_SCREEN;
					DrawCreditsScreen();
				}
				break;
			case GAME_LOOP:
				//Player code
				UpdateColliderPositions();
				//Movement
				MovePlayer();
				//Draw sprites
				DrawPlayer();
				//Check if player has reached end goal
				CheckIfEnd();
				break;
			case END_SCREEN:
				//Check if player has pressed start
				if (inputPad & PAD_START)
				{
					currentGameState = START_SCREEN;
					//ChangeMusic(3);
					DrawTitleScreen();
				}
				break;
			case CREDITS_SCREEN:
				if (inputPad & PAD_START)
				{
					currentGameState = GAME_LOOP;
					GameLoop();
				}
				else if (inputPad & PAD_SELECT)
				{
					currentGameState = START_SCREEN;
					DrawTitleScreen();
				}
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

	// //Clear the screen
	vram_adr(NAMETABLE_A);
	vram_fill(0x00, 1024);

	vram_adr(NAMETABLE_A);
	vram_write(TitleScreen, 1024);


	vram_adr(NTADR_A(12, 5)); // places text at screen position
	vram_write(title, sizeof(title) - 1); //write Title to screen
	//Write prompt to start game
	vram_adr(NTADR_A(6, 18));
	vram_write(titlePrompt, sizeof(titlePrompt) - 1);

	vram_adr(NTADR_A(4, 22));
	vram_write(creditsPrompt, sizeof(creditsPrompt) - 1);
	
	ppu_on_all(); //	turn on screen
}

void GameLoop(void)
{
	//Turn screen off
	ppu_off(); 
	oam_clear();

	//Load palette
	pal_bg(palette);
	pal_spr((const char*)spritePalette);

	switch(currentLevel)
	{
		case 1:
			currentLevelData = Level1;
			player.deathCounter = 0;
			ChangeMusic(4);
			break;
		case 2:
			currentLevelData = Level2;
			ChangeMusic(1);
			break;
		case 3:
			currentLevelData = Level3;
			ChangeMusic(0);
			break;
	}

	//Clear the screen
	vram_adr(NAMETABLE_A);      
	vram_fill(0x00, 1024);
	vram_adr(NAMETABLE_A);      
	vram_write(LoadingScreen, 1024);
	vram_adr(NTADR_A(11, 16));
	vram_write(loadingText, sizeof(loadingText) - 1); 

	ppu_on_all();
	delay(60);
	ppu_off();

	vram_adr(NAMETABLE_A);      
	vram_write(currentLevelData, 1024);

	WriteDeathCounter();

	ppu_on_all();
}

void MovePlayer(void)
{
	if (inputPad & PAD_A && !player.isDashing) 
	{
		player.jumpBufferTimer = JUMP_BUFFER_FRAMES;
	}

	if (OnGround()) 
	{
		player.coyoteTime = COYOTE_FRAMES;
		player.hasDashedInAir = 0;
	} 
	
	if (player.coyoteTime > 0) 
	{
		player.coyoteTime--;
	}

	//-------------------------
    // Horizontal movement
	//-------------------------
	//left
    if (movementPad & PAD_LEFT)
    {
        if (!CheckIfCollidableTile(currentLevelData[GetTileIndex(player.left, player.y + 1)]))
        {
			//Handle movement
			player.x -= PLAYER_SPEED;
			//Set facing right to false
			player.facingRight = 0;
        }
    }

	//Right
    if (movementPad & PAD_RIGHT)
    {
        if (!CheckIfCollidableTile(currentLevelData[GetTileIndex(player.right, player.y + 1)]))
        {
			//Handle Movement
			player.x += PLAYER_SPEED;
			//Set facing right to true
			player.facingRight = 1;
        }
    }

    // Dash mechanic
	//Checks if B pressed, the player is not dashing and the dashCoolDown has not been activated
	if ((inputPad & PAD_B) && !player.isDashing && !(player.dashCooldown > 0)) 
	{
		// Only allow midair dash if the player has not dashed in the air yet
		if (OnGround() || !player.hasDashedInAir)
		{
			player.dashDirection = (movementPad & PAD_LEFT ? -1 : movementPad & PAD_RIGHT ? 1 : 
									player.facingRight ? 1 : -1);
			player.isDashing = 1;
			player.dashTimer = DASH_DURATION;

			//Makes sure no double air dashing
			if (!OnGround())
			{
				player.hasDashedInAir = 1;
			}
		}
	}
	else if (player.dashCooldown > 0) 
	{
		player.dashCooldown--;
	}

	// Check if jump button (A) is pressed, player is not already jumping, and player is currently standing on solid ground
	if (player.jumpBufferTimer > 0 && (!player.isJumping || player.coyoteTime > 0))
	{
		sfx_play(2 , 0);
		//Set the "bool" variable to true
		player.isJumping = 1;
		//Set the velocity to be the constant we defined applies an upward force to the player by being a negative value
		player.velocityY = JUMP_VELOCITY;

		player.jumpBufferTimer = 0;

		player.coyoteTime = 0;

	}
	else if (player.jumpBufferTimer > 0) 
	{
		player.jumpBufferTimer--;
	}

	//-------------------------
	//Dash mechanic
	//-------------------------playerTop
	if (player.isDashing) 
	{
		sfx_play(0 , 0);
		//Decrement the dash timer so that when it runs out player stops dashing
		player.dashTimer--;

		//Checks each pixel individually to make sure it doesn't let the player phase through collidables
		for (i = 0; i < DASH_SPEED; i++) 
		{
			//Calculates the next X position depending on direction
			int nextX = (player.dashDirection == 1) ? player.right + 2 : player.left - 2;

			//Check that there is not a collidable and if there is not then the player can move
			if (!CheckIfCollidableTile(currentLevelData[GetTileIndex(nextX, player.top)]) &&
				!CheckIfCollidableTile(currentLevelData[GetTileIndex(nextX, player.bottom)]))
			{
				player.x += player.dashDirection;
			}
		}

		//When the timer runs out isDashing bool is set to false and cooldown begins
		if (player.dashTimer <= 0) 
		{
			DashEnd();
		}
	}
    else 
    {
        // ----------------------------
		// Jumping mechanic only runs if player is not dashing on the ground
		// ----------------------------
		//Checks for if the player is jumping
        if (player.isJumping && !player.isDashing) 
        {

			//Apply gravity to bring the player back down
            player.velocityY += GRAVITY;

			// Check for head collision and make sure player doesn't jump out the map
			if (player.velocityY < 0) 
			{
				if (CheckIfCollidableTile(currentLevelData[GetTileIndex(player.left + 2, player.top)]) ||
				CheckIfCollidableTile(currentLevelData[GetTileIndex(player.right - 2, player.top)]))
				{
					//Make sure player cannot jump higher and the player doesn't get stuck
					player.velocityY = 0;
					player.y += 1;
				}
			}

			//makeSure hte fall speed doesn't exceed the max value so player doesn't fall too fast
            if (player.velocityY > MAX_FALL_SPEED)
			{
                player.velocityY = MAX_FALL_SPEED;
			}
			//Move the player depending on the value of the velocity velocity starts off negative so it acts as an upwards force
			//As it becomes positive it becomes a downward force to pull the player back
            player.y += player.velocityY;
			//Checks to see if player is stil falling but on the ground
            if (player.velocityY >= 0 && OnGround()) 
            {
				//makes sure that the player doesn't go into the collidable tile
                while (OnGround()) 
				{
					player.y -= 1;
					UpdateColliderPositions();
				}
				//Reset all variables to do with jumping and dashing now that the player is on the ground
				//Also make sure that the player is at ground level so the player is not floating slightly
                player.y += 1;
				UpdateColliderPositions();
                player.velocityY = 0;
                player.isJumping = 0;
				player.hasDashedInAir = 0;
            }
        } 
        else 
        {
			//More of a just in case the player is not on the ground but the value for isJumping is not set to true
			//So it gets set to 1 so gravity can bring the player back down
            if (!OnGround()) 
            {
                player.isJumping = 1;
            }
        }
    }

	if (player.damageTimer > 0)
	{
		player.damageTimer--;

		if (player.damageTimer == 0)
		{
			ResetLevel();
		}
	}

	if (CheckIfSpikes(currentLevelData[GetTileIndex(player.left + 6, player.bottom - 4)]) ||
	CheckIfSpikes(currentLevelData[GetTileIndex(player.right - 6, player.bottom - 4)]) ||
	CheckIfSpikes(currentLevelData[GetTileIndex(player.left + 6, player.top + 4)]) ||
	CheckIfSpikes(currentLevelData[GetTileIndex(player.right - 6, player.top + 4)]))
	{
		if (player.damageTimer == 0)
		{
			player.damageTimer = DAMAGE_TIMER;
		}
	}

	if (player.bottom > 240) 
	{
		ResetLevel();
	}
}

void DrawPlayer(void)
{
	unsigned char playerAttributes = player.isDashing ? 0x03 :
						player.damageTimer > 0 && player.damageTimer % 2 == 0 ? 0x02 :
						player.damageTimer > 0 && player.damageTimer % 2 == 1 ? 0x00 : 0x01;

	if (!player.facingRight)
	{
		playerAttributes |= 0x40;
	}

	//Draw the player
	//Clears all sprite entries in Object Attribute Memory OAM special memopry area that holds info about sprites
	//Such as pos, tile index, palette etc.
	oam_clear();

	if (currentGameState != GAME_LOOP)
	{
		return;
	}
	
	//make sure colliders are in correct position before rendering sprites
	//especially for jumping and dashing
	UpdateColliderPositions();

	if (player.isDashing)
	{
		oam_spr((player.facingRight ? player.left : player.x), player.top, 0x88, playerAttributes);
		oam_spr((player.facingRight ? player.x : player.left), player.top, 0x89, playerAttributes);
		oam_spr((player.facingRight ? player.left : player.x), player.y, 0x98, playerAttributes);
    	oam_spr((player.facingRight ? player.x : player.left), player.y, 0x99, playerAttributes);
	}
	else if (player.isJumping)
	{
		oam_spr((player.facingRight ? player.left : player.x), player.top, 0x0A, playerAttributes);
		oam_spr((player.facingRight ? player.x : player.left), player.top, 0x0B, playerAttributes);
		oam_spr((player.facingRight ? player.left : player.x), player.y, 0x1A, playerAttributes);
    	oam_spr((player.facingRight ? player.x : player.left), player.y, 0x1B, playerAttributes);
	}
	else
	{
		// Draw the player using two tiles: 0x08 (top), 0x24 (bottom)
		oam_spr((player.facingRight ? player.left : player.x), player.top, 0x08, playerAttributes);
		oam_spr((player.facingRight ? player.x : player.left), player.top, 0x09, playerAttributes);
		oam_spr((player.facingRight ? player.left : player.x), player.y, 0x18, playerAttributes);
    	oam_spr((player.facingRight ? player.x : player.left), player.y, 0x19, playerAttributes);
	}
}

unsigned int GetTileIndex(unsigned char playerX, unsigned char playerY)
{
    // Get the x and y tile that the player is currently on Divide by 8 as the players current position is in
	// pixels. Each tile has 8 pixels so we need to divide by 8 to find the tile We need to add scrollX to it 
	//so that we can find the correct position across both halves of the map
    unsigned char tileX = playerX / 8; 
    unsigned char tileY = playerY / 8;
    // As we play in a 64x30 map to first find the correct y position We multiply by 64 to get the correct row
	//Then we add tileX to find the column and the index of the tile
    unsigned int tileIndex = tileY * 32 + tileX;

    return tileIndex;
}

void CheckIfEnd()
{
	if (CheckIfGoalTile(currentLevelData[GetTileIndex(player.left + 4, player.bottom)]) ||
	CheckIfGoalTile(currentLevelData[GetTileIndex(player.right - 4, player.bottom)]))
	{
		sfx_play(3 , 0);
		SetPlayerValues();

		if (currentLevel == 3)
		{
			currentGameState = END_SCREEN;
			DrawEndScreen();
		}
		else
		{
			currentLevel++;
			SetPlayerValues();
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
	SetPlayerValues();
	ChangeMusic(2);

	//Clear the screen
	vram_adr(NAMETABLE_A);            // Set VRAM address to start of screen
	vram_fill(0x00, 1024);

	vram_adr(NAMETABLE_A);            // Set VRAM address to start of screen
	vram_write(WinScreen, 1024);

	vram_adr(NTADR_A(12, 2)); // places text at screen position
	vram_write(title, sizeof(title) - 1); //write Title to screen

	vram_adr(NTADR_A(12, 6)); // places text at screen position
	vram_write(endScreenTitle, sizeof(endScreenTitle) - 1); //write Title to screen
	//Write prompt to start game
	vram_adr(NTADR_A(11, 19));
	vram_write(titlePrompt2, sizeof(titlePrompt2) - 1);

	vram_adr(NTADR_A(10, 21));
	vram_write(endScreenPrompt, sizeof(endScreenPrompt) - 1);

	ppu_on_all(); //	turn on screen
}

char OnGround(void) 
{
	//Make sure player does not land on top of the bottom of the screen
	if (player.bottom + 1 >= 240) return 0;

    return CheckIfCollidableTile(currentLevelData[GetTileIndex(player.right - 6, player.bottom + 1)]) ||
		   CheckIfCollidableTile(currentLevelData[GetTileIndex(player.left + 6, player.bottom + 1)]) ||
		   CheckIfPlatformTile(currentLevelData[GetTileIndex(player.right - 6, player.bottom + 1)]) ||
		   CheckIfPlatformTile(currentLevelData[GetTileIndex(player.left + 6, player.bottom + 1)]);
}

char CheckIfCollidableTile(unsigned char tile) 
{
	//Stores all of the tiles that are collidable and is used to calculate collisions
    return tile == 0x10 || tile == 0x11 || tile == 0x12 || tile == 0x13
		|| tile == 0x80 || tile == 0x81 || tile == 0x82 || tile == 0x83
		|| tile == 0x8E || tile == 0x8F || tile == 0x9E || tile == 0x9F 
		|| tile == 0x90 || tile == 0x91 || tile == 0x92 || tile == 0x93
		|| tile == 0xA0 || tile == 0xA1 || tile == 0xA4 || tile == 0xA5 
		|| tile == 0xA6 || tile == 0xA7 || tile == 0xA8 || tile == 0xA9 
		|| tile == 0xB0 || tile == 0xB1 || tile == 0xB4 || tile == 0xB5 
		|| tile == 0xB6 || tile == 0xB7 || tile == 0xB8 || tile == 0xB9
		|| tile == 0xEE || tile == 0xEF || tile == 0xFE || tile == 0xFF;
}

char CheckIfGoalTile(unsigned char tile) 
{
	//Stores all of the tiles that are collidable and is used to calculate collisions
    return tile == 0x04 || tile == 0x05 || tile == 0x14 || tile == 0x15;
}

void UpdateColliderPositions(void)
{
	//update player colliders
	player.left = player.x - 8;
	player.right = player.x + 8;
	player.top = player.y - 8;
	player.bottom = player.y + 8;
}

void DashEnd(void)
{
	if (player.isDashing)
	{
		player.isDashing = 0;
		player.dashCooldown = DASH_COOLDOWN;
	}
}

char CheckIfPlatformTile(unsigned char tile) 
{
	//Stores all of the tiles that are collidable and is used to calculate collisions
    return tile == 0x84 || tile == 0x85 || tile == 0x94 || tile == 0x95 ||
			tile == 0xE4 || tile == 0xE5 || tile == 0xE6 || tile == 0xF4 ||
			tile == 0xF5 || tile == 0xF6;
}

void SetPlayerValues(void)
{
	player.x = currentLevel == 3 ? 232 : 30;
	player.y = currentLevel == 3 ? 24 : 215;
	player.coyoteTime = 0;
	player.left = 0;
	player.right = 0;
	player.top = 0;
	player.bottom = 0;
	player.facingRight = 1;
	player.velocityY = 0;
	player.isJumping = 0;
	player.jumpBufferTimer = 0; 
	player.isDashing = 0;
	player.dashTimer = 0;
	player.dashCooldown = 0;
	player.hasDashedInAir = 0;
	player.dashDirection = 0;
	player.damageTimer = 0;
}

void ResetLevel(void)
{
	sfx_play(1 , 0);
	ppu_off(); // screen off
	pal_bg(palette); //	load the BG palette
	//Clear all sprite data
	oam_clear();

	player.deathCounter++;

	//Clear the screen
	vram_adr(NAMETABLE_A);      
	vram_fill(0x00, 1024);
	vram_adr(NAMETABLE_A);      
	vram_write(DeathScreen, 1024);
	vram_adr(NTADR_A(10, 8));
	vram_write(respawningText, sizeof(respawningText) - 1); 

	ppu_on_all();
	delay(60);
	ppu_off();

	vram_adr(NAMETABLE_A);      
	vram_write(currentLevelData, 1024);

	WriteDeathCounter();

	SetPlayerValues();

	ppu_on_all();
}

char CheckIfSpikes(unsigned char tile)
{
	return tile == 0x8A || tile == 0x8B || tile == 0x8C || tile == 0x8D ||
		tile == 0x9A || tile == 0x9B || tile == 0xAA || tile == 0xAB ||
		tile == 0xC8 || tile == 0xC9 || tile == 0xD8 || tile == 0xD9;
}

void WriteDeathCounter(void)
{
	vram_adr(NTADR_A(1, 1));
	vram_write(DeathCounter, sizeof(DeathCounter));
	vram_adr(NTADR_A(17, 1));
	sprintf(deathCounterText, "%d", player.deathCounter);
	vram_write((const unsigned char*)deathCounterText, sizeof(deathCounterText));
}

void ChangeMusic(unsigned int trackToChangeTo)
{
	unsigned int currentSpeed = MAX_MUSIC_SPEED;

	while (currentSpeed > MIN_MUSIC_SPEED)
	{
		set_music_speed(currentSpeed);
		delay(6);
		currentSpeed--;	
	}

	music_play(trackToChangeTo);
	set_music_speed(MAX_FALL_SPEED);
}

void DrawCreditsScreen(void)
{
	ppu_off(); // screen off
	pal_bg(palette); //	load the BG palette
	//Clear all sprite data
	oam_clear();

	//Clear the screen
	vram_adr(NAMETABLE_A);      
	vram_fill(0x00, 1024);
	
	vram_adr(NAMETABLE_A);      
	vram_write(WinScreen, 1024);

	vram_adr(NTADR_A(13, 2));
	vram_write(creditsTitle, sizeof(creditsTitle) - 1); 

	vram_adr(NTADR_A(4, 5));
	vram_write(credits1, sizeof(credits1) - 1); 

	vram_adr(NTADR_A(14, 8));
	vram_write(credits2, sizeof(credits2) - 1); 

	vram_adr(NTADR_A(5, 10));
	vram_write(credits3, sizeof(credits3) - 1); 

	vram_adr(NTADR_A(7, 12));
	vram_write(credits4, sizeof(credits4) - 1); 

	vram_adr(NTADR_A(13, 17));
	vram_write(credits5, sizeof(credits5) - 1); 

	vram_adr(NTADR_A(5, 19));
	vram_write(credits6, sizeof(credits6) - 1); 

	vram_adr(NTADR_A(5, 21));
	vram_write(credits7, sizeof(credits7) - 1); 

	vram_adr(NTADR_A(6, 25));
	vram_write(titlePrompt, sizeof(titlePrompt) - 1); 

	vram_adr(NTADR_A(1, 27));
	vram_write(startScreenPrompt, sizeof(startScreenPrompt) - 1); 

	ppu_on_all();
}
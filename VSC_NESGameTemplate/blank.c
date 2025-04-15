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


	Pro Tip: Add a Simple Pause Menu
	Here’s a little trick you could build on:

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
#include "NES_ST/TestLevel.h"
#include <stdlib.h>

//Define colours
#define BLACK 0x0f
#define DK_GY 0x00
#define LT_GY 0x10
#define WHITE 0x30

//define game states
#define START_SCREEN 0
#define GAME_LOOP 1
#define END_SCREEN 2

//palette colours
const unsigned char palette[]={
BLACK, DK_GY, LT_GY, WHITE,
0,0,0,0,
0,0,0,0,
0,0,0,0
}; 

#pragma bss-name(push, "ZEROPAGE")

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
signed char playerX = 15;
signed char playerY = 223;
//Goal variables
signed char goalX = 200;
signed char goalY = 200;
//Gravity and jumping variables
unsigned char gravity = 3;
signed char maxJump = -30;
signed char playerJumping = 0;
unsigned char i;

//function prototypes
void DrawTitleScreen(void);
void GameLoop(void);
void Fade(void);
void MovePlayer(void);
void DrawPlayer(void);
unsigned int GetTileIndex(unsigned char playerX, unsigned char playerY);
void CheckIfEnd(void);
void DrawEndScreen(void);


//MAIN
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
	vram_adr(NAMETABLE_A);   // Set VRAM address to the top-left of the screen
	vram_write(TestLevel, 1024);
	//Load palette
	pal_bg(palette);
	pal_spr((const char*)palette);

	ppu_on_all();
}

void MovePlayer(void)
{
	// In the collission checks for the x coordinates having the playerY 
	// Param just be playerY made it not let you move left and right when
	// Collided with the top of the map
	if(movementPad & PAD_LEFT)
	{
		//Check for collision 1 pixel to left of player
        if (TestLevel[GetTileIndex(playerX - 1, playerY + 1)] != 0x01)
        {
			//If false allow player to move
            playerX--;
        }
	}
	
	if(movementPad & PAD_RIGHT)
	{
		// Check for collision 9 pixels to the right of the player
        if (TestLevel[GetTileIndex(playerX + 8, playerY + 1)] != 0x01)
        {
			//If false then allow player to move
            playerX++;
        }
	}

	

	if (TestLevel[GetTileIndex(playerX, playerY + 9)] != 0x01)
	{
		//If false then allow player to move
		playerY += 1;
	}
	else
	{
			/// Handle jumping (if the player is pressing the jump button)
		if (inputPad & PAD_A)
		{
			playerJumping = 30;
		}
	}

	if (playerJumping >= 0)
	{
		playerY -= gravity;
		playerJumping -= gravity;
	}


	
	// if(movementPad & PAD_UP)
	// {
	// 	//Check for collision 1 pixel to left of player
    //     if (TestLevel[GetTileIndex(playerX, playerY)] != 0x01)
    //     {
	// 		//If false allow player to move
    //         playerY--;
    //     }
	// }
	
	// if (movementPad & PAD_DOWN)
	// {
	// 	// Check for collision 9 pixels to the right of the player
    //     if (TestLevel[GetTileIndex(playerX, playerY + 9)] != 0x01)
    //     {
	// 		//If false then allow player to move
    //         playerY++;
    //     }
	// }
}

void DrawPlayer(void)
{
	//Clears all sprite entries in Object Attribute Memory
	//OAM special memopry area that holds info about sprites
	//Such as pos, tile index, palette etc.
	oam_clear();
	//Draw the player sprite at default starting position
	//Using the fourth sprite in the character sheet
	//0x00 is the attribute, controls flipping and priority
	oam_spr(playerX, playerY, 0x04, 0x00);
	oam_spr(goalX, goalY, 0x05, 0x00);
}

unsigned int GetTileIndex(unsigned char playerX, unsigned char playerY)
{
    // Get the x and y tile that the player is currently on
	//Divide by 8 as the players current position is in pixels
	//Each tile has 8 pixels so we need to divide by 8 to find the tile
    unsigned char tileX = playerX / 8; 
    unsigned char tileY = playerY / 8;
    
    // As we play in a 32x32 map to first find the correct y position
	//We multiply by 32 to get the correct row
	//Then we add tileX to find the column and the index of the tile
    unsigned int tileIndex = tileY * 32 + tileX;

    return tileIndex;
}

void CheckIfEnd()
{
	// Calculate the distance between the middle of both sprites
	if (abs((playerX + 4) - (goalX + 4)) < 6 && 
	abs((playerY + 4) - (goalY + 4)) < 6)
	{
		currentGameState = END_SCREEN;
		DrawEndScreen();
	}
}

void DrawEndScreen()
{
	ppu_off(); // screen off
	pal_bg(palette); //	load the BG palette

	//Clear all sprite data
	oam_clear();

	//Set varirables back to their default value
	playerX = 15;
	playerY = 223;

	//Clear the screen
	vram_adr(NAMETABLE_A);            // Set VRAM address to start of screen
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
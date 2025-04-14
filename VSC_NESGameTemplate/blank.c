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
unsigned char pad;
//Player variables
unsigned char playerX = 10;
unsigned char playerY = 223;



//function prototypes
void DrawTitleScreen(void);
void GameLoop(void);
void Fade(void);


//MAIN
void main (void) 
{
	DrawTitleScreen();

	// infinite loop
	while (1)
	{
		//Waits for next frame
		ppu_wait_nmi();
		pad_poll(0);
		pad = get_pad_new(0);

		switch(currentGameState)
		{
			case START_SCREEN:
				//Check if player has pressed start
				if (pad & PAD_START)
				{
					currentGameState = GAME_LOOP;
					GameLoop();
				}
				else
				{
					Fade();
				}
				break;
			case GAME_LOOP:
				//Fade();

				if(pad & PAD_LEFT)
				{
					playerX -= 1;
				}
				else if (pad & PAD_RIGHT)
				{
					playerX += 1;
				}
				if(pad & PAD_UP)
				{
					playerY -= 1;
				}
				else if (pad & PAD_DOWN)
				{
					playerY += 1;
				}
				
				oam_clear();
				oam_spr(playerX, playerY, 0x04, 0x00);

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
	pal_spr(palette);
	ppu_on_all();
}

void Fade(void)
{
	pal_fade_to(4,0); // fade from normal to black
	//delay(50);
	pal_fade_to(0,4); // fade from black to normal
	//delay(50);
}
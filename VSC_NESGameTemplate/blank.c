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

//Define colours
#define BLACK 0x0f
#define DK_GY 0x00
#define LT_GY 0x10
#define WHITE 0x30

//define game states
#define START_SCREEN 0
#define GAME_LOOP 1
#define END_SCREEN 2


#pragma bss-name(push, "ZEROPAGE")

// GLOBAL VARIABLES
unsigned char i;
//Defines which state the game is currently in (START_SCREEN, GAME_LOOP or END_SCREEN)
unsigned char currentGameState = START_SCREEN;

const unsigned char text[] = "Nocturnes Blood"; 
const unsigned char titlePrompt[] = "Press START";
const unsigned char gameLoopText[] = "This is the game loop";
const unsigned char endScreenTitle[] = "End Screen";
const unsigned char endScreenPrompt[] = "To play again";

unsigned char pad;

//palette colours
const unsigned char palette[]={
BLACK, DK_GY, LT_GY, WHITE,
0,0,0,0,
0,0,0,0,
0,0,0,0
}; 

//function prototypes
void DrawTitleScreen(void);
void GameLoop(void);
void Fade(void);

void main (void) 
{
	DrawTitleScreen();

	// infinite loop
	while (1)
	{
		//Waits for next frame
		ppu_wait_nmi();
		pad = pad_trigger(0);

		if (pad)
		{
			
			// Show something if *any* button is pressed
			vram_adr(NTADR_A(2, 20));
			vram_put('0' + (pad >> 4)); // just a crude test
			vram_put('0' + (pad & 0x0F));

		}

		if (pad & PAD_START)
		{
			currentGameState = GAME_LOOP;
			GameLoop();
		}

		switch(currentGameState)
		{
			case START_SCREEN:
				//Check if player has pressed start
				Fade();
				//DrawTitleScreen();
				break;
			case GAME_LOOP:
				Fade();
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

	vram_adr(NTADR_A(3, 6));
	vram_write(titlePrompt, sizeof(titlePrompt) - 1);

	ppu_on_all(); //	turn on screen
}

void GameLoop(void)
{
	//Turn screen off
	ppu_off(); 

	vram_adr(NAMETABLE_A);   // Set VRAM address to the top-left of the screen
	vram_fill(0, 32*30);     // Fill 32 columns × 30 rows with tile 0 (blank)

	//Load palette
	pal_bg(palette);

	//Set VRAM ADDRESS TO ROW 10 COL 10
	vram_adr(NTADR_A(10, 10));
	vram_write(gameLoopText, sizeof(gameLoopText) - 1);

	ppu_on_all();
}

void Fade(void)
{
	pal_fade_to(0,4); // fade from black to normal
	delay(50);
	pal_fade_to(4,0); // fade from normal to black
	delay(50);
}
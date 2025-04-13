/*	simple Hello World, for cc65, for NES
 *  writing to the screen with rendering disabled
 *	using neslib
 *	Doug Fraker 2018
 */	
 
 
 
#include "LIB/neslib.h"
#include "LIB/nesdoug.h" 

#define BLACK 0x0f
#define DK_GY 0x00
#define LT_GY 0x10
#define WHITE 0x30
// there's some oddities in the palette code, black must be 0x0f, white must be 0x30
 
#pragma bss-name(push, "ZEROPAGE")

// GLOBAL VARIABLES
// all variables should be global for speed
// zeropage global is even faster

unsigned char i;

const unsigned char text[]="Escape Villavania!"; // zero terminated c string

const unsigned char palette[]={
BLACK, DK_GY, LT_GY, WHITE,
0,0,0,0,
0,0,0,0,
0,0,0,0
}; 


void main (void) {
	
	ppu_off(); // screen off
	pal_bg(palette); //	load the BG palette

	//Set VRAM address to row 10 and column 12
	vram_adr(NTADR_A(12, 10)); // places text at screen position
	vram_write(text, sizeof(text)-1); //write Title to screen

	// vram_adr and vram_put only work with screen off
	// NOTE, you could replace everything between i = 0; and here with...
	// vram_write(text,sizeof(text));
	// does the same thing
	ppu_on_all(); //	turn on screen
	
	
	while (1){
		// infinite loop
		// game code can go here later.
		
		pal_fade_to(0,4); // fade from black to normal
		delay(100);
		pal_fade_to(4,0); // fade from normal to black
		delay(100);
	}
}
	

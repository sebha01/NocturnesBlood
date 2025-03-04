/*	simple Hello World, for cc65, for NES
 *  writing to the screen with rendering ON
 *	using neslib
 *	Doug Fraker 2018
 */	


 
#include "LIB/neslib.h"
#include "LIB/nesdoug.h"
#include "NES_ST/ZhaoCena.h"


#define BLACK 0x0f
#define DK_GY 0x00
#define LT_GY 0x10
#define WHITE 0x30

// there's some oddities in the palette code, black must be 0x0f, white must be 0x30
const unsigned char palette[]={
BLACK, DK_GY, LT_GY, WHITE,
0,0,0,0,
0,0,0,0,
0,0,0,0
}; 	

void main (void) {
	ppu_off(); // screen off

	pal_bg(palette); //	load the palette
	
	vram_adr(NAMETABLE_A);
	// this sets a start position on the BG, top left of screen
	// vram_adr() and vram_unrle() need to be done with the screen OFF
	
	vram_unrle(ZhaoCena);
	// this unpacks an rle compressed full nametable
	// created by NES Screen Tool
	
	ppu_on_all(); // turn on screen
	
	while (1){
		// infinite loop
		// game code can go here later.


		pal_fade_to(0,4); // fade from black to normal

		pal_fade_to(4,0); // fade from normal to black
	}
}
	
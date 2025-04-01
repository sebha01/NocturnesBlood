/*	simple Hello World, for cc65, for NES
 *  writing to the screen with rendering disabled
 *	using neslib
 *	Doug Fraker 2018
 */	
 
 
 
#include "LIB/neslib.h"
#include "LIB/nesdoug.h" 

//#link "chr _generic.s"

#define BLUE 0x02
#define FUSCHIA 0x14
#define GREY 0x20
#define WHITE 0x30
// there's some oddities in the palette code, black must be 0x0f, white must be 0x30

const unsigned char palette[]={
BLUE, FUSCHIA, GREY, WHITE,
0,0,0,0,
0,0,0,0,
0,0,0,0
}; 

// main function, run after console reset
void main(void) {
	int x;

	//------------ WAITING CODE --------------------//
	//for (x=0; x<500; x++) { // <-- add these lines
		//ppu_wait_frame(); // <-- after
	//} // <-- ppu_on_all()
	//----------------------------------------------//

	ppu_off();
	pal_bg(palette);

	// write text to name table
	vram_adr(NTADR_A(2,2));		// set address
	vram_write("HELLO, WORLD!", 13);	// write bytes to video RAM

	// enable PPU rendering (turn on screen)
	ppu_on_all();

	// infinite loop
	while (1);
}
	

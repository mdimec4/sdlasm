all:
	nasm -f elf64 sdl_window.asm 
	gcc -fPIE -pie sdl_window.o -o sdl_window `sdl2-config --libs` `pkg-config --libs SDL2_image`

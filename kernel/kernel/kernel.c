#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include <stdio.h>

#include <kernel/tty.h>

void kernel_early(void)
{
	terminal_initialize();
}

void kernel_main(void)
{
	printf("Hello there, kernel World!\n");
	printf("Welcome.\n\nThis is a newline.\n\n");
	
	int i = 0;
	while(i < 30){
		printf("Doing some operation...\n");
	}
}

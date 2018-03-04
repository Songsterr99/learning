#include <stdio.h>

void showMenu(int number) {
	printf("______________MINSK AIRLINES______________\n              FLIGHT no. %d\n\n\n", number);
	printf("\n****************\nMenu:\na- amount of empty seats\nb - list of empty seats\nc - list of reserved seats(alphabetic order)");
	printf("\nd - book seat\ne - accept reservation\nf - cancel reservation\ng - exit\n****************\n\n");
}
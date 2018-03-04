#include "variables.h"
#include "functions.h"
#include "Interface.h"
#include <stdio.h>
#include <string.h>

int main(){
        char* filenames[] = { "101.txt", "102.txt", "201.txt", "202.txt" };
        int flight;
	printf("Enter number of flight(101, 102, 201, 202):\n" );
	
	scanf("%d", &flight);
	int num = chooseNumFlight(flight);

	int id = 0;
	init();
	readData(filenames[num]);
	char option;
	while(option != 'g'){
		showMenu();
		printf("Enter your option:\n");
		scanf("%s", &option);
		switch (option){
		case 'a':
			printf("Amount of empty seats: %d\n", amountEmpty());
			break;
		case 'b':
			listOfEmpty();
			break;
		case 'c':
			listOfReserved();
			break;
		case 'd':
			printf("Enter number of the place:\n");
			scanf("%d", &id);
			if(array[id - 1].marker == 0){
				array[id - 1].marker = 1;
				printf("Enter your name:\n");
				scanf("%s", array[id - 1].FI);
				printf("Do you want to book this place\n 1 - yes\n2 - no \n");
				int place;
				scanf("%d", &place);
				if(place == 1){
					acceptPlace(id - 1);
				}
			} else {
				printf("Seat is already locked!\n" );
			}
			break;
		case 'e':
			printf("Select number of the locked places you want to book:\n");
			scanf("%d", &id);
			acceptPlace(id - 1);
			break;
		case 'f':
	 		printf("Select number of the place locking that you want to cancel: \n");
			scanf("%d", &id);
			if (array[id-1].marker > 0)
				array[id-1].marker = 0;
			break;
		case 'g':
			 break;
		}
	}

	writeData(filenames[num]);

	return 0;
}
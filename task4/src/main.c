#include "var.h"
#include "func.h"
#include "UI.h"
#include <stdio.h>
#include <string.h>

int main(){
	printf("Minsk Airlines\n");

	printf("Choose your flight(101, 102, 201, 202):\n" );
	int flight;
	char *flight_name[] = {"flight101.txt", "flight102.txt", "flight201.txt", "flight202.txt"};
	scanf("%d", &flight);
	int num = chooseFlight(flight);

	int indc = 0;
	init();
	readData(flight_name[num]);
	char c;
	while(c != 'g'){
		printMenu();
		printf("Enter your option:\n");
		scanf("%s", &c);
		switch (c){
		case 'a':
			printf("The number of free places: %d\n", freePlacesCount());
			break;
		case 'b':
			freePlacesList();
			break;
		case 'c':
			lockedPlacesList();
			break;
		case 'd':
			printf("Select number of the place:\n");
			scanf("%d", &indc);
			if(array[indc - 1].marker == 0){
				array[indc - 1].marker = 1;
				printf("Your name:\n");
				scanf("%s", array[indc - 1].FI);
				printf("Do you want to book this place\n 1 - yes\n2 - no \n");
				int place;
				scanf("%d", &place);
				if(place == 1){
					acceptPlace(indc - 1);
				}
			} else {
				printf("Seat is already locked\n" );
			}
			break;
		case 'e':
			printf("Select number of the locked places you want to book:\n");
			scanf("%d", &indc);
			acceptPlace(indc - 1);
			break;
		case 'f':
	 		printf("Select number of the place locking that you want to cancel: \n");
			scanf("%d", &indc);
			if (array[indc-1].marker > 0)
				array[indc-1].marker = 0;
			break;
		case 'g':
			 break;
		}
	}

	writeData(flight_name[num]);

	return 0;
}

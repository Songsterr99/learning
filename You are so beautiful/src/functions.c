#include "variables.h"
#include <stdio.h>
#include <string.h>

void init(){
	for (int i = 0; i < SIZE; i++){
		strcat(array[i].FI, "nothing");
		array[i].number = i+1;
		array[i].marker = 0;
	}
}


int amountEmpty(){
	int	result = 0;

	for (int i = 0; i < SIZE; i++){
		if(array[i].marker == 0)
			++result;
	}

	return result;
}

void listOfEmpty(){
	for (int i = 0; i < SIZE; i++){
		if (array[i].marker == 0)
			printf("%d ", array[i].number);

	}
	printf("\n");
}

int firstPlace(int check[SIZE]){
	for(int i = 0; i < SIZE; i++) {
		if(check[i] == 0)
			return i;
	}
	return SIZE;
}

void listOfReserved(){
	int check[SIZE];
	for(int i = 0; i < SIZE; i++){
		check[i] = 0;
	}

	for (int i = 0; i < SIZE; i++){
		int numb = firstPlace(check);
		for(int j = 0; j < SIZE; j++){
			if(strcmp(array[j].FI, array[numb].FI) < 0 && check[j] == 0){
				numb = j;
			}
		}
		check[numb] = 1;
		printf("%s - place: %d\n",array[numb].FI, numb + 1);
	}
}

void acceptPlace(int n){
	if (array[n].marker == 1)
		array[n].marker = 2;
	else if(array[n].marker == 0)
		printf("You selected empty place.\n");
	else if(array[n].marker == 2)
		printf("You selected accepted place.\n" );
	else
		printf("This place doesn't exist.\n");
}

int writeData(char file[15]){
  FILE *mf = fopen(file, "w");
	if(mf == NULL)
  	return 0;

	for (int i = 0; i < SIZE; i++){
		fprintf(mf, "%d %d %s\n", array[i].number, array[i].marker, array[i].FI);
	}

	fclose(mf);
	return 1;
}

int readData(char file[15]){
  FILE *mf = fopen(file, "rt");
	if(mf == NULL || feof(mf))
  	return 0;

		for (int i = 0; i < SIZE; i++){
			fscanf(mf, "%d %d %s\n", &array[i].number, &array[i].marker, array[i].FI);

		}


	fclose(mf);
	return 1;
}

int chooseNumFlight(int number){
switch (number) {
	case 101:
		return 0;
	case 102:
		return 1;
	case 201:
		return 2;
	case 202:
		return 3;
	default:
		return -1;
}
}

main:	main.o functions.o Interface.o
	gcc -o bin/main main.o functions.o Interface.o
	mv main.o build
	mv functions.o build
	mv Interface.o build

functions.o: src/functions.c
	gcc -c src/functions.c

main.o: src/main.c
	gcc -c src/main.c

Interface.o: src/Interface.c
	gcc -c src/Interface.c

clean:
	rm -f bin/main

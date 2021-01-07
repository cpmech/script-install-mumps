all:
	mpicc -g -Wall -I/usr/local/include/mumps -L/usr/local/lib/mumps c_example.c -o c_example -ldmumps
	./c_example

clean:
	rm c_example
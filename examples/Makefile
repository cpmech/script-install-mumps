FLAGS  = -g -Wall
PREFIX = /usr/local
INCDIR = $(PREFIX)/include/mumps
LIBDIR = $(PREFIX)/lib/mumps
LIBS   = -ldmumps_open_mpi

.PHONY: all clean

all:
	mpicc $(FLAGS) -I$(INCDIR) -L$(LIBDIR) c_example.c -o c_example $(LIBS)

clean:
	rm c_example
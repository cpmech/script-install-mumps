FLAGS  = -g -Wall
PREFIX = /usr/local
INCDIR = $(PREFIX)/include/mumps
LIBDIR = $(PREFIX)/lib/mumps
LIBS   = -ldmumps_open

all:
	mpicc $(FLAGS) -I$(INCDIR) -L$(LIBDIR) c_example.c -o c_example $(LIBS)

.PHONY: clean
clean:
	rm c_example
FLAGS  = -g -Wall
PREFIX = /usr/local
INCDIR = $(PREFIX)/include/mumps
LIBDIR = $(PREFIX)/lib/mumps
LIB_SEQ = -ldmumps_open_seq

.PHONY: all clean

all: c_example_seq

c_example_seq: c_example_seq.c
	gcc $(FLAGS) -I$(INCDIR) -L$(LIBDIR) $@.c -o $@ $(LIB_SEQ)

clean:
	rm c_example_seq

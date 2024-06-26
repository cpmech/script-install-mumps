#
#  This file is part of MUMPS 5.6.2, released
#  on Wed Oct 11 09:36:25 UTC 2023
#

# must be at the top
PLAT = _cpmech

# Begin orderings
LSCOTCHDIR = 
ISCOTCH   = 

LSCOTCH   = 

LPORDDIR = $(topdir)/PORD/lib/
IPORD    = -I$(topdir)/PORD/include/
LPORD    = -L$(LPORDDIR) -lpord$(PLAT)

LMETISDIR = /usr/lib 
IMETIS    = -I/usr/include

LMETIS    = -L$(LMETISDIR) -lmetis

# Corresponding variables reused later
ORDERINGSF = -Dmetis -Dpord
ORDERINGSC  = $(ORDERINGSF)

LORDERINGS = $(LMETIS) $(LPORD) $(LSCOTCH)
IORDERINGSF = $(ISCOTCH)
IORDERINGSC = $(IMETIS) $(IPORD) $(ISCOTCH)
# End orderings
################################################################################

LIBEXT_SHARED  = .so
SONAME = -soname
FPIC_OPT = -fPIC
# Adapt/uncomment RPATH_OPT to avoid modifying
# LD_LIBRARY_PATH in case of shared libraries
# RPATH_OPT = -Wl,-rpath,/path/to/MUMPS_x.y.z/lib/
LIBEXT  = .a
OUTC    = -o 
OUTF    = -o 
RM = /bin/rm -f
CC = mpicc
FC = mpiifort
FL = mpiifort
AR = ar vr 
RANLIB = ranlib
MKLROOT=/opt/intel/oneapi/mkl/latest/lib/intel64
LAPACK = -L$(MKLROOT) -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core
SCALAP = -L$(MKLROOT) -lmkl_scalapack_lp64 -lmkl_blacs_intelmpi_lp64

INCPAR = # not needed with mpif90/mpicc:  -I/usr/include/openmpi

LIBPAR = $(SCALAP) $(LAPACK)

INCSEQ = -I$(topdir)/libseq
LIBSEQ  = $(LAPACK) -L$(topdir)/libseq -lmpiseq$(PLAT)

LIBBLAS = -L$(MKLROOT) -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core 
LIBOTHERS = -lpthread

#Preprocessor defs for calling Fortran from C (-DAdd_ or -DAdd__ or -DUPPER)
CDEFS   = -DAdd_

#Begin Optimized options
# below, -diag-disable=10448 avoids Intel's warning about ifort being deprecated
OPTF    = -O -nofor-main -fopenmp -DGEMMT_AVAILABLE  -diag-disable=10448
OPTL    = -O -nofor-main -fopenmp
OPTC    = -O -fopenmp
#End Optimized options

INCS = $(INCPAR)
LIBS = $(LIBPAR)
LIBSEQNEEDED =


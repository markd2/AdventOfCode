# add new exercises to this
allTheThings = allocatable allocatableString arithmetic arraySlice arrays dowhile float hello ifs loopy module readValue string subby typey variables tsunami coldfront elemental printCompilerInfo

all: $(allTheThings)

%: %.f90
	gfortran -g -O0 -fbacktrace -fcheck=all $< -o $*

clean:
	rm -rf $(allTheThings) a.out *.o *.mod *~ *.dSYM

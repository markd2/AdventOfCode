# add new exercises to this
allTheThings = allocatable allocatableString arithmetic arraySlice arrays dowhile float hello ifs loopy module readValue string subby typey variables tsunami coldfront elemental printCompilerInfo

all: $(allTheThings)

%: %.f90
	gfortran -g -O0 -fbacktrace -fcheck=all $< -o $*

tsunami: modInitial.f90 modDiff.f90 tsunami.f90
	gfortran -g -O0 -fbacktrace -fcheck=all modInitial.f90 modDiff.f90 tsunami.f90 -o tsunami

stockGain: stockGain.f90
	gfortran -g -O0 -fbacktrace -fcheck=all mod_alloc.f90 mod_arrays.f90 mod_io.f90 stockGain.f90 -o stockGain

clean:
	rm -rf $(allTheThings) a.out *.o *.mod *~ *.dSYM

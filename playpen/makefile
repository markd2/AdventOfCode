# add new exercises to this
allTheThings = allocatable allocatableString arithmetic arraySlice arrays dowhile float hello ifs loopy module readValue string subby typey variables

all: $(allTheThings)

%: %.f90
	gfortran $< -o $*

clean:
	rm -f $(allTheThings) a.out *.o *.mod *~

# add new exercises to this
allTheThings = test1 test2

all: $(allTheThings)

%: %.f90
	gfortran $< -o $*

clean:
	rm -f $(allTheThings) a.out *.o

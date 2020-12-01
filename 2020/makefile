# add new exercises to this
allTheThings = day1

all: $(allTheThings)

%: %.f90
	gfortran $< -o $*

clean:
	rm -f $(allTheThings) a.out *.o

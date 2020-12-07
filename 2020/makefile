# add new exercises to this
allTheThings = day1 day2 day3 day4 day5 day6 day7 day8 day9 day10 day11 day12 day13 day14 day15 day16 day17 day18 day19 day20 day21 day22 day23 day24 day25 hashtbl

all: $(allTheThings)

%: %.f90
	gfortran $< -o $*

day7: hashtbl.o day7.f90
	gfortran -c day7.f90
	gfortran day7.o hashtbl.o -o day7

hashtbl.o:
	gfortran -c hashtbl.f90

clean:
	rm -f $(allTheThings) a.out *.o *.mod *~

# 2020

FORTRAN, because why not.  Last FORTRAN I did was in the 80s - had it in the UCSD pascal system
on an Apple ][, and took a college course in it during high school at UALR one summer. Some days
I miss VAX/VMS


## Day 4 - Passport Processing

https://adventofcode.com/2020/day/4

TL;DR

* Read in some key:value records, blank line seperates

```
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929
```

* Check for validity - 7 fields are required, one is optional.

#### Preflight

I've done list-directed breaking on spaces, and also splitting on colons, so
that can be adapted. I don't care about the values for the keys (for now), so
don't need to find a hash table yet.

Maybe just have an "accumulate" that sets a flag in a structure, and then the
structure can be evaluated for correctness.

The twist probably includes meaningful processing of the values, perhaps like
the `year` fields for expiray

### Notes

Wow, not proud of any of that code.  Obiwan at the end.  Would have liked to have
had a scoring function, but couldn't figure out (and still get some sleep tonight)
where to put my struct definition, so just copy and pasted things. And also one 
submission failure because didn't handle the last record properly.


### Part 2

Twist - validate the data.

Might skip this for now until I read more about the language beyond caveman level.


## Day 3 - Toboggan Trajectory

https://adventofcode.com/2020/day/3

TL;DR

* read in a grid of open spaces `.` and trees `#`

e.g.


* Then, start at (1, 1) (fortran 1-index)
* repeat until fall off the bottom
  - move right 3, down 1
  - incr count if on a tree
* report the number of trees
* if fall off the right, then repeat the pattern

#### Example

```
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
```

is the grid.  For this solution, it'd be repeated horizontally 3 times, with this
path of X and O:

```
..##.........##.........##.......
#..O#...#..#...#...#..#...#...#..
.#....X..#..#....#..#..#....#..#.
..#.#...#O#..#.#...#.#..#.#...#.#
.#...##..#..X...##..#..#...##..#.
..#.##.......#.X#.......#.##.....
.#.#.#....#.#.#.#.O..#.#.#.#....#
.#........#.#........X.#........#
#.##...#...#.##...#...#.X#...#...
#...##....##...##....##...#X....#
.#..#...#.#.#..#...#.#.#..#...X.#
```

With the total counted here being 7.


#### Preflight

This hopefully will go smoother than yesterday, since it's just reading in lines (323 in
the input), and doing mod math (being aware of fenceposts on the wrap)

The twist for part two?  Something where just doing mod math in a loop won't cut it.  Maybe if
hit a tree reposition to a space.

#### Notes

The mod math in a 1-index world was annoying.  So keep the index zero-based, and
then bias it by one when looking up values.

### Part 2

Twist - parameritize the alogrithm (right 1 down 1, or right 5 down 1)

Ended up making a little type

```
  type :: SledVector
     integer :: right ! east
     integer :: down  ! south
  end type SledVector
```

I did screw up the loop indexing for the "down 2" case, starting one row off and getting way the wrong
number. Help me Obiwan Kenobi...


----------


## Day 2 - Password Philosophy

https://adventofcode.com/2020/day/2

### Part 1

TL;DR

* Find non-conforming passwords
* Read in the record of the form X-Y Z: abcdef
  - where X and Y are a numeric range  (one or two digits
  - Z is a single character
  - abcdef is a password
* X is the minimum number of times the letter should appear
* Y is the maximum number
* Count the number of valid passwords

#### Example

```
1-3 a: abcde      (valid)
1-3 b: cdefg
2-9 c: ccccccccc  (valid)
```

#### Preflight

Hrm.  Reading the problem statement, looks like "ooh cool, I can use FORMAT stuff because
these look like fixed-record punch cards", but the various widths, e.g.

```
11-13 m: snglklmpcmmmm
5-10 j: cxjfwpxjwgjh
4-6 f: ffhffzfnf
```

kind of blows that out.  Wonder if the fortran has more flexible format parsing these days.

Nope.  Either list-driven (which the minus-sign in there messes up) or format driven (fixed columns)
Ended up reading into a string, then breaking that apart.  Adapted stuff from
http://fortranwiki.org/fortran/show/getvals (thank you!)

Outside of that, looks like a straightforward "count the number of Z inside of the string" and then
compare it to the numeric range.

So, if it was 

Figuring, process as a stream - that way I won't have to store stuff in an array.  Just read, verify,
then count

twist?  Maybe multiple characters


### Part 2

A rule change. The numbers aren't number of characters, but instead character positions
(1-indexed. FORTRAN FTW in that case).  Exactly one of those positions must contain the
given letter.  Everything else is irrelevant.


```
1-3 a: abcde      (valid)
1-3 b: cdefg      (invalid)
2-9 c: ccccccccc  (invalid)
```

Pretty trivial:

```
    inPosition1 = password(position1:position1) .eq. required
    inPosition2 = password(position2:position2) .eq. required

    valid = inPosition1 .neqv. inPosition2
```
[Solution](day2.f90)


----------

## Day 1 - Report Repair

https://adventofcode.com/2020/day/1

### Part 1

TL;DR

* Have a list of numbers
* Find the two entries that sum to 2020 
* Then multiply those two together

#### Example

```
1721
979
366
299
675
1456
```

`1721 + 299 .eq. 2020`

Therefore this answer is `1721 * 299 .eq. 514579`


#### Preflight

Looks like a simple permute and check.  F90 doesn't have a hugely rich set
of operators that I'm aware of, so assuming it'll be two nested loops, and
then ~break~ `cycle` when two add up to 2020.  I'm assuming that there's just
one, because of "Find _the_ two entries" in the problem statement.

Wondering what the twist will be.  Could be "ok, there's now N items to match",
so just plain old nested loops won't work in that case.  Maybe it's correlate two
parallel arrays?  Not sure. So will go with the butt-simple approach.

### Part 2

Yep, it's _three_ numbers.

Running out of time this morning, so doing the cheap-ass way by copying and pasting.

[Solution](day1.f90)



# 2020

FORTRAN, because why not.  Last FORTRAN I did was in the 80s - had it in the UCSD pascal system
on an Apple ][, and took a college course in it during high school at UALR one summer. Some days
I miss VAX/VMS


## Day 9 - Encoding Error

TL;DR

* the cypher:
  - 25 number preamble
  - each number after that should be the sum of any two of the 25 immediately
    prior numbers. (not using the same number twice if I'm reading it
    correctly)
* What is the first number that violates that invariant?

### Notes

Straightforward.  Still doing obiwans because of my brain wired for zero-index


### Part 2

Twist: Find a contiguous set of at least two nubmers, where the sum of all the
       items in the list add to the target number.
     - then find the sum of the smallest and largest number in this range

It says "find blah _in your list_, which implies it's not limited to the 
preamble.

Nested loops.  Pretty straightforward.



## Day 8 - Handheld Halting

Just the name makes me nervous

TL;DR

* three-instruction processor (nop, jmp, add to accumulator)
* execute program. ~When~ Before an instruction is reached a second time
* print out the value of the accumulator


### Preflight

This is definitely a more Fortranny kind of deal.  Three parallel arrays:
seen(logical), opcode, parmeter, plus an accumulator.

Twist?  Problably the actual halting problem.  Or maybe detect repeated
subsequences of instructions.  Or maybe accumulator overflow

### Notes

really straightforward

### Twist

change jmp to nops, or nops to jmps and see if the program falls off the end.

basically, outer loop going from 1 through the end.  If the instruction
is a jmp, change to nop, then run.  If it hits the end, then groovy and
we win, report the accumulator.



## Day 7 - Handy Haversacks

TL;DR
* luggage!
* bags are color-coded, and contain specific quantities of other bags
* rule of the form
  - adjective color bags  contain  number adjective bag(s), (list may repeat), period
* we have a shiny gold bag. We want to carry it in at least one other bag
  (so don't start off with shiny gold)
* so could have bag-type-A which holds shiny gold bag directly
  - or bag type B, that holds A, that holds shiny gold
* question to solve: how many bag colors can eventually contain at least one shiny gold bag?


Example rules

```

dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
```



### Preflight

yikes.  

Maybe start with some kind of lookup table (say by bag color), with a list of bags
that it contains.  Actually, if the table is reversed from the rules.

So above,

shiny gold ------> live in bright white
           +-----> live in muted yellow
bright white ----> live in light red
             +---> live in dark orange
             +---> root
muted yellow +---> live in bright white
             +---> root
faded blue +-----> live in shiny gold
           +-----> live in dark olive
           +-----> live in vibrant plum
           +-----> root
vibrant plum +---> live in dark olive
             +---> root
dotted black +---> live in faded blue
             +---> root
dark orange  +---> root
light red  +-----> root

So the possible bags for shiny gold are:

* find shiny gold. Follow up to live in root. If get to root, add to set
```
  - shiny gold ->  bright white -> root  - BRIGHT WHITE
                   -> light red -> root - LIGHT RED
                   -> dark orange -> root - DARK ORANGE
               ->  muted yellow -> root  - MUTED YELLOW
```

So four colors, which is the test data solution

sample rule

```
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
```

Things interested in

```
shiny-gold-bags ignored ignored  dark-olive-bag, ignored vibrant-plum- bags.
```

Fortran hash table example.

http://fortranwiki.org/fortran/show/hash+table+example

TIL about ELEMENTAL functions.
Also, got it working 
```
  use hashtbl
  implicit none
  type(hash_tbl_sll) :: table
  
  character(len=:), allocatable :: out

  call table%init(100)

  call table%put(key="bright white", val="12")

  call table%get("bright white", out)
  print *, allocated(out)
  print *, out

  call table%get("splunge", out)
  print *, allocated(out)
```

It can only hold strings.  Holding an array would be nice, but already burned
an hour on getting the above working.  So maybe store space-separated
oop-ack-blargh and then use that for the lives-in values. Alternative is
putting the oop-ack-blargh into an array and storing a numerical index
in the lives-in array.

First hurdle is just parsing the line.  yeah, this is sucking so much time.

May try to see if I can get the algorithm done with swift, then see how
I could express it fortran-styles.  Hoping the fortran book I'm chewing through
has some insight on what i'm not understanding.


#### Twist?

twist - so many directions the twist could go.  Keep counts, so include the transitive
closure?  adjective becoming important?  TBH I'll be happy if I can solve part 1
 during my morning freetime.


### Part 2

Twist is - what is the total number of bags required inside of the shiny gold bag?











## Day 6 - Custom Customs

https://adventofcode.com/2020/day/6

TL;DR

* passengers are in arbitrary groups
* They answer a T/F questionairre
* collect the number of unique T responses.

Here's three records

```
abc

a
b
c

ab
ac
```

* Each boils down to `abc` having set to true

#### Preflight

* Can re-use the newline-seperated record approach
* Still haven't looked for a hashtable data structure, so thinking of an
  array of 26 logicals, and using the letter as an index into it.
* Maybe a letterSet type

Twist?  Maybe if the set of values expands (update letter->index translation).
Or we need to collect counts (then array of integers rather than bools)

#### Notes

Pretty straight forward (6310).  Still really struggling with strings and passing to procedures

### Part 2

instead of couting the ones where someone said yes, but where everyone said yes.
So yes, (yes), need to keep counts.

Doing the straightforward thing, getting too large a value (3201).

Argh - included one stray AnySeen rather than AllSeen.  (3193)

----------

## Day 5 - Binary Boarding

https://adventofcode.com/2020/day/5

TL;DR

* Start with 128 (or 8), then number-guessing-game them by slicing off half.
* that gives a row / column (row, seat) index
* calculate the linear index (row * 8 + set)

#### Preflight

Feeling off-by-1 fencepost obiwans in my future.

Twist?  This problem statement is essentially "this is a binary number",
so the twist would be something that breaks that assumption.

#### Part 2

Find ID of your seat, it'll be the only missing boarding pass.
Some of the seats at the very front and back of the plane don't exist.

So 761 lines in the file.  Luckily our fencepost is such that our seat
is ID +/- 1

So, what's the size of the complete set of numbers?  1024.  bit set of ones we've seen

So, the 
we get 
```
          37
          38
          39
         597
         802
         803
         804
```

So find the first discontinuity. That was pretty straightforward.  YAY



----------


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

had fun making it OO and cleaing up.

150 (for my data set) is too high, so false positives getting in

Wasn't handling verification for empty strings (missing fields) properly



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



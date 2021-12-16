# Advent of Code 2021

Going to be using Swift, maybe use the algo packge as well.  Used FORTRAN last year,
and ran out of available time.  It was fun, but frustrating when doing [alot](http://hyperboleandahalf.blogspot.com/2010/04/alot-is-better-than-you-at-everything.html)
of string processing.

I'm using swift-sh (https://nshipster.com/swift-sh/) so I can use swift scripts with SwiftAlgorithms (https://github.com/apple/swift-algorithms)


## Day 1 - Sonar Sweep

* https://adventofcode.com/2021/day/1

Sleigh Keys flying into the ocean!  Oh noes!  Get into a submarine covered in
christmas lights, and need to collect 50 ~macguffins~ stars

### Part the first

Sonar sweep report - each line is a (numeric integer) measurement of the sea
floor depth as the depth (in unspecified units.  I'll call them _fleems_)
 looks futher and further away

```
199
200
208
210
200
207
240
269
260
263
```

"first order of business is to figure out how quickly the depth increases",
**count the number of times a depth measurement increases** from the previous
one

```
199 (N/A - no previous measurement)
200 (increased)
208 (increased)
210 (increased)
200 (decreased)
207 (increased)
240 (increased)
269 (increased)
260 (decreased)
263 (increased)
```

In this case, there's **7** measurements that are larger than the previous one.

PROBLEM # 1: How many measurements are larger than the previous measurement

General approach - 

* pull in the goodies
* loop over array (1 ..< counnt) with indices
* compare x[1] with x[0]
* accumulate count


Here's the workable brute force version

```
    for i in 1 ..< ints.count {
        if ints[i] > ints[i-1] {
            increases += 1
        }
    }
```

Using Swift Algorithms adjacent pairs:

```
let pairs = ints.adjacentPairs()

increases = pairs
  .filter { (oldFleems, newFleems) in return newFleems > oldFleems }
  .count
```


### Part the second

Guess at the twist - needing to use the values in some way.  If the deltas are
increasing or decreasing.

Actual twist - "three measurement sliding window"

```
199  A      
200  A B    
208  A B C  
210    B C D
200  E   C D
207  E F   D
240  E F G  
269    F G H
260      G H
263        H
```

So compare the BBB values vs the AAA values, then the CCC values vs the BBB values

Can think of the first problem in terms of two measurement sliding windows.
(was actually back-of-brain thinking of tuples, but didn't follow through)

Adapted from DaveDelong's solution

```
    increases = ints.windows(ofCount: 3)
      .map(\.sum)
      .adjacentPairs()
      .filter { (oldFleems, newFleems) in 
          return newFleems > oldFleems }
      .count
```

The map sum is an extension

```
extension Sequence where Element: Numeric {
    var sum: Element {
        var sum: Element = 0
        forEach { blah in
            sum += blah
        }
        return sum
    }
}
```

==================================================
## Day 2 - Dive!

How to pilot this thing

Three commands
  - forward X - go forward by X fleems
  - down X - increase depth by X fleems
  - up X - decrease depth by X fleems

"down and up affect your depth, and so they have the opposite result
of what you might expect" - ?

### Part the first
  
For example
```
forward 5
down 5
forward 8
up 3
down 8
forward 2
```

Horizontal position and depth both start at zero

| command   | horizontal | vertical |
| ----------|------------|----------|
|    start  |  0         |  0       |
| forward 5 |  5         |  0       |
| down 5    |  5         |  5       |
| forward 8 | 13         |  5       |
| up 3      | 13         |  2       |
| down 8    | 13         | 10       |
| forward 2 | 15         | 10       |

horizontal position is 15
vertical position is 15

multiplied is 150

Without knowing the twist, there's two approaches - read each line and process it,
or break everything down into a set of commands (array of enums), and a little
machine that'll reduce the starting positions with the commands.

Feeling lazy, so going to do the least elegant thing.

```
for each line {
    chunks = split line on space
    value = Int(chunks[1])

    switch chunks[0] {
    case "forward":
        horizontal += value
    case "down":
        vertical += value
    case "up":
        vertical -= value
    default:
        print("argh: \(line)")
    }
}
```


### Part the Second

The twist is rather than h/v positions, there's an _aim_ that causes
`forward` to take the current aim into account.  Still pretty easy to
muscle through.

```
for each line {
    chunks = split line on space
    value = Int(chunks[1])

    switch chunks[0] {
    case "forward":
        horizontal += value
        vertical += aim * value
    case "down":
        aim += value
    case "up":
        aim -= value
    default:
        print("argh: \(line)")
    }
}
```

==================================================
# Day 3 - Binary Diagnostic

Get a binary code from the sub:

```
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
```

(the real data is wider, coming in at 12 bits, 000000010011)

So do some bitwise-gamgee work on it

## Part the First

For each _Column_ of bits, if the number of 1 bits wins, then a 1 survives
to the final value, otherwise a zero.  This aggregate number is **gamma**
rate.  Flip the bits and get the **epsilon** rate.  Multiply the two and get the
final value, and emit it in decimal.

Since bit counts are being used, accumulate them in buckets

```
var buckets: [Int] = Array(repeating: 0, count: bitcount)

// Count number of 1 bits in each position
lines.forEach { line in
    for (i, character) in line.enumerated() {
        buckets[i] += (character == "1") ? 1 : 0
    }
}
```

And then walk the counts, this time doing binary stuff.  It's kind of annoying
needing to `-1` the array index.

```
var epsilon: UInt = 0
var gamma: UInt = 0
for i in 0 ..< bitcount {
    if buckets[bitcount - i - 1] > totalLines / 2 {
        epsilon |= 1 << i
    } else {
        gamma |= 1 << i
    }
}
```

### Part the Second

This time **oxygen generator rating** and **CO2 scrubber rating**.

This looks tedious.  "filtering out values until only one remains"

* keep only numbers selected by the _bit criteria_ for the type of rating
  - discard values that do not match this filter

Bit Criteria
- **O2 generator**
    - determine the most common value (0, 1) in the current bit position
    - keep only numbers with the bit in that position
    - if 0 and 1 are equally common, keep values with 1 in that position
- **CO2 Scrubber**
    - flipped - keep values with 0 in that position

So it's a winnowing.

All the things
  - take out the ones 

==================================================
# Day 4 - Giant Squidly

Playing bingo(e) with a giant squid.

**bingo subsystem FTW**

## Part the first

* File format is a row of numbers, followed by bingo squares
* No diagonals
* if all in row or column are marked that board _wins_

Score a board by
- finding the sum of all unmarked numbers on the board
- multily that sum by the number that was just called

Figure out which board wins first, and what is the final score.

Guessing the twist will be of all boards, perhaps a change to the win calculation

So, sounds ike we've got a 

* Board, with the 5x5 grid.  Make a new Board with each provided grid
  - contructor that takes the array of strings
* tell the board when each number is drawn.
  - the board figures out if it's a winner
  - the board figures out its own score

Processing loop

```
for each draw
  for each board in order
      inform board of the draw
      winp?  If so, print score, and bail
```

`zip` is a thing I should use more often. It's fun

## Part the second

"let the giant squid win"

Figure out which board will win last and choose that one.

Real low-class way, but works.  I'm not interested in the winning boards, so every
time see a winning board, store its index into a set.  When that set has seen
everything, then we know the current board is the winner.  yay

--------------------------------------------------
# Day 5 - Hydrothermal Venture

OMG HYDROTHERMAL VENTS!  Avoid them if possible.

They form in lines.  The sub produces a list of nearby lines of vents, e.g.

```
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
```

Each line of vents is given as a line segment in the format (x1,y1) -> (x2,y2) where
they're the ends of the line segment (inclusive)

"FOR NOW" only consider horizontal and veritcal lines (I imagine this is going to
be the twist.  Bresenham's time?)  (assuming other lines we can ignore

* For a coordinate of e.g. 1,1->1,3, this is 1,1, 1,2, 1,3
  - horizontal has common first elemnt
* or 9,7->7,7, this is points 9,7, 8,7, 7,7
  - vertical common second element

Top-left is (0,0, and bottom-right is 9,9).
Sum the number of lines that cover that point.  Multiple intersecting lines will
hit that point

Approach:
* build line objects. Along the way we can figure out the max width/height for the
  world
  - toss lines that aren't horionztal/vertical
    - cardinalDirectionP %-)
* make a world grid
* iterate lines and apply to the world
* score by counting how many points at least two lines overlap.

## Part the second

Yep diagonal lines. But perfectly (45 degree) diagonal.  (makes it a TON easier).

_lines in your list will only ever be horizontal, vertical, or a diagonal line at exactly 45 degrees_, so something is diagonal if it's not horizontal or vertical.

Having trouble visualizing the diagnoal, so for `5, 5 -> 2, 8`, it's the X's in

```
  0123456789
0 .......1..
1 ..1....1..
2 ..1....1X.
3 .......X..
4 .11211X211
5 .....X....
6 ..........
7 ..........
8 ..........
9 222111....
```

--------------------------------------------------
# Day 6 - Lanternfish

ut oh.  It says _exponentialy_.  Plus DaveDeLong says "uh guys do NOT try to brute-force
it unless you have a freakton of RAM".  I suggested AWS and a big loan.

First read through I found inscrutible. This time with notes

* "surely" each laternfish creates a new oen every _7_ days
* not synchronized - one might have 2 days left until it makes another one,
  and another might have 4
* can model each fish as a single number representing the number of days until
  it creates a new lanternfish
* a new fish would take two more days for its first cycle

Example.

- Fishy with internal timer of 3
- next day, timer goes to 2
- next day, timer goes to 1
- next day, timer goes to 0
- next day, interneal timer resets to 6 _(why six?)_
  - creates a new lantern fish with an internal timer of 8 _(6 + 2)_
- next day, first fish would have internal timer of 5, second internal timer of 7

ah, it's six because new fish every 7 days, and because 0 is a legit value

assuming no deaths, cannibalism, or trying to walk in Star Citizen..

The input is the current timers

```
3,4,3,1,2
```

so first fish has an internal timer of 3, second of 4, ...

3,4,3,1,2
2,3,2,0,1 <- new fishy tomorrow
1,2,1,6,0,8 <-< new fishy tomorrow
0,1,0,5,6,7,8
etc, growing bighuge

after 18 days, these five grew to 26.  Then after 80 total of 5934. 

So.  It's huge.

## Part the first

Storing each individual fish (the aforementioned (big) Bruté) is a non-starter,
with 300 in the prod data aset.  The 18 day would be 90,000, and then assuming
an exponent of 2.7, 4.8 million (which doesn't sound *too* bad...)

so instead, store counts of fish at each time increment.

Process by:
* the 0s, save off
* move everyone down a slot (so 0 gets clobbered)
* add 0s to 6
* add 0s to 8

yes!  that worked well


## Part the second

Same, but with more (256 days instead of 8) (going from 351188 -> 1595779846729 for
my data set).  Just a one line-change

```
- let finalDay = 80
+ let finalDay = 256
```

Yay for navitve 64-bit integer types.

==================================================
# Day 7 - The Treachery of Whales

oh noes! Thar Be Whales Here!  They want to nom us.

There's a bunch of friendly crabs (in submaries, naturally) spread out across the ocean
floor. Have them move horizontally until they line up, but using the position of least
resistance.

## Part 1

Dave DeLong whispered "Triangular numbers".

Going to brute-force it first (the max size in my production data is around 1880)
so should be able to exhaustively search through the space.  Guessing the twist will
make that approach untenable.

But it worked and was pretty straightforward to write.

## Part the second

ah, fuel cost is non-linear.  Each step costs one more fuel.  

So moving from 0 to 5, that's 
0->1 = 1,  1
0->2 = 2,  3
2->3 = 3   6
3->4 = 4  10 
4->5 = 5  15

nesting that into the rest of the calculation

```
func fuelCost(position: Int, army: [Int]) -> Int {
    // How I first learned sigma notation.x
    func sigma(x: Int) -> Int {
        (0...x).reduce(0, +)
    }

    return army.reduce(0, { $0 + sigma(x: abs($1 - position)) })
}
```

is a massive cpu spike.  _sad trombone_ - this is the usual "Swift can have poor
performance in non-optimized builds".  I let it run 5-10 minutes ramping up my fans
(but not nearly as badly as with BitDefender running).  Running it optimized for
Instrumeting (just curious what the real problem was), and it finished nearly immediately.
#iLoveYouSwift.

Ah, this is the triangular number thing Dave was talking about.

--------------------------------------------------
# Day 8: Seven Segment Search

uh.... 7-segment LED info(e) dump, With that much lead-in, either the
twist is going to be hell, or these will stretch over a couple days
worth of puzzles

```
 aaaa  
b    c 
b    c 
 dddd  
e    f 
e    f 
 gggg  
```

and input line like

```
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
```

Ten unique signal paatterns (so "here are the different ways I can render 0...9), a pipe, and then four-digit output value

## Part the first

The first problem seems to be 
"count the number of 1, 4, 7, 8 segment numbers", which devolves
into not understanding anything - just parsing the input line and finding
strings of the proper length (2, 4, 3, and 7 respectively)

* Split on the pipe, then split on spaces on each side.
* Have a Display struct (since there's no modifications required at least
  for part 1) with the set of 10 signal patterns and then the four digits
  being displayed

## Part the second

yay, so now actually figure out what the segments are, then sum them up.
(WE'RE GONNA SUM <clap> YOU UHP)

So figure out which signal wire (A...G) corresponds with which segment (a...g)

that'll be fun.

1, 4, 7, 8 will be the lunchpins  Given that, can we know anything?

```
1:   c  f
4:  bcd f
7: a c  f
8: abcdefg
```
n
Can't really uniquely determine anything from thatexcept the bottom segment (thanks
to the 8). each of the other segments appear in at least xtwo digits

The complete breakdown

```
0: abc efg
1:   c  f
2: a cde g
3: a cd fg
4:  bcd f
5: ab d fg
6: ab defg
7: a c  f
8: abcdef
9: abcd fg
```

So we'll see each of those.  What are the counts?
```
a: 8
b: 6
c: 7
d: 7
e: 4
f: 9
g: 6
```

rotated
```
4: e
6: b
7: dg
8: ac
9: f
```

Is this useful information?


if a wire appears four times (e.g. E) in the signal patterns, then that 
must be the lower-left segment e

So immediately we should be able to bucket line e, b, and f, 
gand partition the other six segments.

Pick up the third line for fun:
x
```
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef
```

sorting the internal components for sanity

```
abdefg cg abcde abdfg abcdfg bcdefg abcdg acfg bcg abcdefg
```

We know that

```
definitely 1:   c   g
definitely 4: a c  fg
definitely 7:  bc   g 
definitely 8: abcdefg
maybe 0 or 9: ab defg 
              abcd fg
maybe 2356  : abcde 
              ab d fg 
               bcdefg 
              abcd  g
```

histogram of counts

```
a: 7
b: 8
c: 8
d: 7
e: 4
f: 6
g: 9
```

should get one each of 4, 6, 9, two of 7 8. (yay)

so we know that for the given wires (lowercase) we know these segments (uppercase):

```
E: e  (b/c 4 e's)
B: f  (b/c 4 f's)
G: g  (b/c 9 g's)
```

so now we know that anything with with an 

```
e has E turned on, and so must be a 0,2,6,8
f has B turned on, and so must be a 0,4,5,8,9
g has G turned on, and so must be a 0,2,3,5,6,8,9
```

hrm. what does that tell us?  I dunno.  That's :alot: of piles of info.

Hypothesis - if we can figure out wire to SEGMENT mapping, then it becomes
trivial to map segments to digits (ABCEFG == 0, CF == 1, etc)

letting subconcious chew on this for a bit

--------------------------------------------------
# Day 9 - Smoke Basin.

Given a matrix of numbers which are a height map

```
2199943210
3987894921
9856789892
8767896789
9899965678
```

## Part the first

So walk through each row/column and see if it's the lowest point

"sum of the levels of all low points."  make a function given a row/column,
see if it is a low point.  It'll have if's.  I could be clever and pad everything
with 9s, so would always have something a low point around.

999999999999
921999432109
939878949219
998567898929
987678967899
998999656789
999999999999

a low point is that are lower than any of its adjacent locations.

## Part the second

Find the largest basins to know what to avoid.

A basin is all locations that eventualy flow downward to a single low point.

* Every low point has a basin
* locations of height 9 do not count as being basins

The size of a basin is the number of locations within the basin including the low point

I think can be driven by the low points.

For each point:
  - add non 9-9 neighbors into the list

actually, once I got into it, decided to write everything connected (including 9/9) into
a `Set<Point>` and then trim the 9s.  seems to work!

--------------------------------------------------
# Day 10: Syntax Scoring

Delimiter matching with () [] {} and <>, nested

Two flavors of lines
* incomplete
* corrupted

```
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
```


## Part the first

Find and discard the corrupted lines, where a chunk closes with the wrong charater

Find the first illegal character in each line, and make the score based on the wrong character.

Have a stack, when see an open delimiter, push it.  When see a close delimiter, it
better match the top of the stack. if not, it is corrupted.  (vs just running out of characters
with stuff on the stack, that makes things incomplete)

## Part the second

the stuff on the stack are the things that would complete the string, so pop those off.


--------------------------------------------------
# Day 11: Dumbo Octopus

```
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
```

octopuses in a 10x10 grid.  Each grows energy (+1 each turn) and flashes when full
(going to 10)

Can model in discrete steps
* First, increment energy of each octopus by 1
* any with a level > 9 flashes
    - incrementing 8 neighbors
    - setting its level to 0
    - any thing that exceeds 9 also flashes
    - continue until flashing stops

## Part the First

after 100 steps, count the total number of flashes.

figure go through it row/column, incrementing each. If get a flash, then start recursing
on all the things that flash.

Using a -1 for a "flashed" otherwise the 0 value would get incremented again (or not)


## Part the second

first step when all octopussies flash


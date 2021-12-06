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

----------

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


### Part the second

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

actually on my home computer and I'm away from it right now

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
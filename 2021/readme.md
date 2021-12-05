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



# Advent of code 2023

Was contemplating doing this year's in Zig (just because) or Kotlin (due to
some work stuff), but this december is CRAZYpants (at least in the beginning),
so will fall back to comfy languages.

Welp, I *was* going to do Swift, but yay:

```
% swift sh
error: unable to invoke subcommand: swift-sh (No such file or directory)
```

So, Objective-C it is until I can get swift fixed on this machine. _sigh_

Update: looks like past-me in 2021 used https://nshipster.com/swift-sh/, 
for easier running of swift files as scripts.


## Day 1 - Trebuchet

https://adventofcode.com/2023/day/1

### Part 1

Looks like a "scan string from ends, make a number"

```
1abc2        == 12
pqr3stu8vwx  == 38
a1b2c3d4e5f  == 25
treb7uchet   == 7
```

Let's take a moment and marvel at the examples, that answered all the
questions I had.

And yay, got it right.

### Part 2

lol.  that's hilarious.  Need to look up character strings as well.

```
two1nine          = 29
eightwothree      = 83
abcone2threexyz   = 13
xtwone3four       = 24
4nineeightseven2  = 42
zoneight234       = 14
7pqrstsixteen     = 76
```

(kind of tedious...)

hrm.  eyeballing, seems to work fine.  I am parsing eighthree as 83 and
sevenine as 79, but saying I'm too low.  

Heh. Ran it through a random python script from reddit, and it got a
lower value (by six). Also wrong.

Found a "thought there'd be a pear, but nothing there

original: 55336
with a stupid memory fix: 30093
python script: 55330
found a C++ version 55343
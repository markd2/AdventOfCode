# Advent of code 2023

Was contemplating doing this year's in Zig (just because) or Kotlin (due to
some work stuff), but this december is CRAZYpants (at least in the beginning),
so will fall back to comfy languages.

Welp, I *was* going to do Swift, but yay:

```
% swift sh
error: unable to invoke subcommand: swift-sh (No such file or directory)
```

I swear, there must be an `if markd-is-looking-forward-to-coding { fail(random()) }} gate` in the apple dev tools.

So, Objective-C it is until I can get swift fixed on this machine. _sigh_


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
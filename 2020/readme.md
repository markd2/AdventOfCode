# 2020

FORTRAN, because why not.  Last FORTRAN I did was in the 80s - had it in the UCSD pascal system
on an Apple ][, and took a college course in it during high school at UALR one summer. Some days
I miss VAX/VMS


## Day 1 - Report Repair

### Part 1

https://adventofcode.com/2020/day/1

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

# 2020

FORTRAN, because why not.  Last FORTRAN I did was in the 80s - had it in the UCSD pascal system
on an Apple ][, and took a college course in it during high school at UALR one summer. Some days
I miss VAX/VMS

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



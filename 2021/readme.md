# Advent of Code 2021

Going to be using Swift, maybe use the algo packge as well.  Used FORTRAN last year,
and ran out of available time.  It was fun, but frustrating when doing [alot](http://hyperboleandahalf.blogspot.com/2010/04/alot-is-better-than-you-at-everything.html)
of string processing.


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


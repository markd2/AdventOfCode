# Advent of Code 2024.

Woo!  Lord knows how long I'll stick with it, but love starting them.

I don't have the bandwidth for a new language this year, so good ol' Swiftage.

# Day 1

https://adventofcode.com/2024/day/1

basically, take a table

```
3   4
4   3
2   5
1   3
3   9
3   3
```

Sort both columns, and take the pairwise distance.

Yay, works!

What about the twist? Some different math - maybe keep the numbers in the same order?

### Day 1.2

similarity scores - basically accumulate the right column into a counted
set.


# Day 2

today's task is to pull apart a list of numbers, and apply some rules:
  * numbers are all increasing or decreasing
  * adjacent numbers don't differ by more than three.
  * (equal values violate both conditions)

Twist?  Either more complex logic in a row, or we'll need to do comparisons
across rows?

### Day 2.1



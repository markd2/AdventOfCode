# Advent of Code 2022

This year using AoC to learn C++!  I am some kind of masochist!!11!

Reindeer food!

## Day 1

https://adventofcode.com/2022/day/1

### Part 1

We get a list of numbers separated by blank lines.  Each group
of numbers is an Elf's local food supply in calories.  e.g. sample:

```
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
```
Elf 1 has 6000 calories, second elf is 4000 calories, etc.

One elf is carrying the most calories,  what is that value?
In this case, it's 24000 from the fourth elf.

#### Approach

* Stream the file in
* nom numbers as they come in and sum them
* when hit a blank line, max the current max and the running sum
* go to nom numbers until hit new line
* return the max


#### Twist Guess

I imagine the twist will involve knowing which elf has the most
calories - my obvious solution is not keeping track of **which** specific
elf has all the calories, just how many total.

#### Learnings






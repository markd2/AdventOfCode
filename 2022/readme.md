# Advent of Code 2022

This year using AoC to learn C++!  I am some kind of masochist!!11!

Reindeer food!

## Day 2

https://adventofcode.com/2022/day/2

Rock Paper Scissors!

### Part 1



#### Approach

#### Solution

#### Twist Guess

#### Learnings

### Part 2

#### Approach

#### Solution

#### Twist Guess

#### Learnings

--------------------------------------------------

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

#### Solution

69626

_(of course, my solution is different than yours)_


#### Twist Guess

I imagine the twist will involve knowing which elf has the most
calories - my obvious solution is not keeping track of **which** specific
elf has all the calories, just how many total.

#### Learnings

* `getline(cin, lineString)` to read a line from stdin
* use `line.empty()` to see the blank space
* `stoi(lineString)` to convert string to integer.

### Part 2

The twist is - keep track of the top _three_ elves calories, and
calculate that sum.

For the example, the top three elves are the fourth (24000),
third (11000), fifth (10000).

So don't need the identity of the elf

#### Approach

instead of letting the sums float by / keeping the max.  Dump into
an array. Sort. Take the top 3.  Sum them.

(there's also an approach from Data Oriented Design that might 
look at if there's time)

#### Solution

206780

==================================================

## Day X

https://adventofcode.com/2022/day/X

### Part 1

#### Approach

#### Solution

#### Twist Guess

#### Learnings

### Part 2

#### Approach

#### Solution

#### Twist Guess

#### Learnings

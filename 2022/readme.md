# Advent of Code 2022

This year using AoC to learn C++!  I am some kind of masochist!!11!

Reindeer food!

## Day 3

https://adventofcode.com/2022/day/3

Rucksack reorganization.

There's a set of rucksacks, each with the same number of items.
Items are keyed by upperand lowercase characters. `F` is one thing and
`f` is another.  Given a description of the rucksack contents, e.g, 
_"vJrwpWtwJgWrhcsFMMfFFhFp"_, split it in half for each rucksack
vJrwpWtwJgWr and hcsFMMfFFhFp, and find the error (the same item in both,
so a lower case p)

Then score them 1-26 (lowercase) and 27-52 (uppercase) by "the priority
of the item type that apears in both compartments.

The example doesn't have overlapping found items - do they just want the
_type_ (so if `p` appears 17 times in the data, then it contributes singly to
the total) or the actual itmes (so it contributes 17 times to the total).

The example also show exactly one conflict, but can there be multiple?
Guess we'll find out.

### Part 1

#### Approach

The actual work seems pretty straightforward:
  - split string in half
  - dump each character in to a set
  - intersect the sets
  - score the contents of the sets

#### Solution

#### Twist Guess

Probably will involve fixing the rucksacks - given all the leftovers, distribute
them so there's no conflicts


#### Learnings

### Part 2

#### Approach

#### Solution

#### Learnings


## Day 2

https://adventofcode.com/2022/day/2

Rock Paper Scissors!

### Part 1

Data:

* Column 1
    - A : Rock
    - B : Paper
    - C : Scissors
* Column 2 (supposition)
    - X : Rock
    - Y : Paper
    - Z : Scissors
* scoring
    - Shape Score
        - 1 : Rock
        - 2 : Paper
        - 3 : Scissors
    - Round Score
        - 0 : lost
        - 3 : drawn
        - 6 : won

Then sum up :all-the-things:. What is the total score.

#### Approach

2500 lines in the prod data set.  Shouldn't be a problem - linear scan,
calculate, sum.  

#### Solution

9651. First try.

#### Twist Guess

Guessing that XYZ stand for different things. Might be dependent on
the first column. Might be a backtracking thing. "X for what your opponent
chose two rounds ago".  Or maybe it turns in to rock paper scissors lizard spock
Or maybe it's calculate the opponent score too.

#### Learnings

Opportunity to learn up on enum classes (a.k.a. scoped enumerations).  Basically
a scoping/namespacing mechanism (no methods like in swift-land). Does allow
for switch-exhaustiveness checking.

Doesn't seem to be a `split`, but stringstreams come close for space-delimited ones.

```
        std::stringstream ss(line);
        std::string opponent, player;
        ss >> opponent;
        ss >> player;
```


### Part 2

Twist is:

* Column 2
    - X : Lose
    - Y : Draw
    - Z : Win

#### Approach

Add a couple of "convert RPS move X into win/lose" and use the existing scoring 
functions.

#### Solution

10560 (first try!)

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

#### Learnings

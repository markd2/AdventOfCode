# 2019

2019 dealies.

https://adventofcode.com/2019/

## Day 1

Needing to calculate fuel requireents

* amount needed to launch a _module_ is based on its _mass_
* take its mass, divide by 3, round down, subtract 2
    - mass of 12:  12 / 3 == 4, -2 == 2
    - mass of 14:  12 / 3 == 4.6666 == 4, -2 == 2
    - mass of 100756:  100756 / 3 = 33,585.33 == 33585, -2 == 33583
* the fuel counter-upper&trade; needs to know the total, so calculate
  mass for each module (puzzle input) and sum all the values



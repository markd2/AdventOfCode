package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"sort"
	"strconv"
	"strings"
)

func main() {
	// Read input file
	file, err := os.Open("day-1-prod.txt")
	if err != nil {
		fmt.Printf("Error opening input file: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	var firstNumbers []int
	var secondNumbers []int

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := scanner.Text()
		numbers := strings.Fields(line)
		if len(numbers) != 2 {
			fmt.Printf("Invalid line format: %s\n", line)
			continue
		}

		firstNum, err := strconv.Atoi(numbers[0])
		if err != nil {
			fmt.Printf("Error converting first number: %v\n", err)
			continue
		}

		secondNum, err := strconv.Atoi(numbers[1])
		if err != nil {
			fmt.Printf("Error converting second number: %v\n", err)
			continue
		}

		firstNumbers = append(firstNumbers, firstNum)
		secondNumbers = append(secondNumbers, secondNum)
	}

	if err := scanner.Err(); err != nil {
		fmt.Printf("Error reading file: %v\n", err)
		os.Exit(1)
	}

	// Sort both arrays
	sort.Ints(firstNumbers)
	sort.Ints(secondNumbers)

	// Calculate differences and running sum
	runningSum := 0
	for i := 0; i < len(firstNumbers); i++ {
		diff := int(math.Abs(float64(secondNumbers[i] - firstNumbers[i])))
		runningSum += diff
		fmt.Printf("Pair %d: (%d, %d) diff = %d, running sum = %d\n",
			i+1, firstNumbers[i], secondNumbers[i], diff, runningSum)
	}

	fmt.Printf("\nFinal running sum: %d\n", runningSum)
}

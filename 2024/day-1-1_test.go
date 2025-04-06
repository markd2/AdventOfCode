// Package main_test provides tests for the number difference calculator.
// The tests verify that the program correctly:
//   - Calculates absolute differences between pairs of numbers
//   - Sorts numbers before calculating differences
//   - Handles empty input by returning zero
//   - Processes command line arguments for input file selection
package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"testing"
)

func TestMain(t *testing.T) {
	// Create a temporary test file
	content := []byte("100 200\n300 400\n500 600")
	testFile := "test_input.txt"
	err := os.WriteFile(testFile, content, 0644)
	if err != nil {
		t.Fatal(err)
	}
	defer os.Remove(testFile)

	// Save original args and restore after test
	oldArgs := os.Args
	os.Args = []string{os.Args[0], testFile}
	defer func() { os.Args = oldArgs }()

	// Run the main function
	main()
}

func TestCalculateDifferences(t *testing.T) {
	tests := []struct {
		name          string
		firstNumbers  []int
		secondNumbers []int
		expectedSum   int
		expectedError bool
	}{
		{
			name:          "Simple case",
			firstNumbers:  []int{1, 2, 3},
			secondNumbers: []int{4, 5, 6},
			expectedSum:   9, // After sorting: |4-1| + |5-2| + |6-3| = 3 + 3 + 3 = 9
			expectedError: false,
		},
		{
			name:          "Larger numbers",
			firstNumbers:  []int{10, 20, 30},
			secondNumbers: []int{40, 50, 60},
			expectedSum:   90, // After sorting: |40-10| + |50-20| + |60-30| = 30 + 30 + 30 = 90
			expectedError: false,
		},
		{
			name:          "Unordered numbers",
			firstNumbers:  []int{3, 1, 2},
			secondNumbers: []int{6, 4, 5},
			expectedSum:   9, // After sorting: |4-1| + |5-2| + |6-3| = 3 + 3 + 3 = 9
			expectedError: false,
		},
		{
			name:          "Empty arrays",
			firstNumbers:  []int{},
			secondNumbers: []int{},
			expectedSum:   0,
			expectedError: true,
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			t.Logf("Running test case: %s", tt.name)
			t.Logf("First numbers: %v", tt.firstNumbers)
			t.Logf("Second numbers: %v", tt.secondNumbers)
			t.Logf("Expected sum: %d", tt.expectedSum)

			// Create test file with the test data
			testFile := "test_input.txt"
			content := []byte{}
			for i := 0; i < len(tt.firstNumbers); i++ {
				content = append(content, []byte(fmt.Sprintf("%d %d\n", tt.firstNumbers[i], tt.secondNumbers[i]))...)
			}

			err := os.WriteFile(testFile, content, 0644)
			if err != nil {
				t.Fatal(err)
			}
			defer os.Remove(testFile)

			// Save original args and restore after test
			oldArgs := os.Args
			os.Args = []string{os.Args[0], testFile}
			defer func() { os.Args = oldArgs }()

			// Run the main function and capture output
			oldStdout := os.Stdout
			r, w, err := os.Pipe()
			if err != nil {
				t.Fatal(err)
			}
			os.Stdout = w
			main()
			w.Close()
			os.Stdout = oldStdout

			// Read the output
			var output string
			scanner := bufio.NewScanner(r)
			for scanner.Scan() {
				output += scanner.Text() + "\n"
			}
			t.Logf("Program output:\n%s", output)

			// Check for expected error conditions
			if tt.expectedError {
				if !strings.Contains(output, "Final running sum: 0") {
					t.Errorf("Expected zero sum for empty arrays, got output:\n%s", output)
				}
				return
			}

			// Extract the final sum from the output
			lines := strings.Split(output, "\n")
			var finalSum int
			for _, line := range lines {
				if strings.Contains(line, "Final running sum:") {
					fmt.Sscanf(line, "Final running sum: %d", &finalSum)
					break
				}
			}

			if finalSum != tt.expectedSum {
				t.Errorf("Expected sum %d, got %d\nTest case: %s\nFirst numbers: %v\nSecond numbers: %v",
					tt.expectedSum, finalSum, tt.name, tt.firstNumbers, tt.secondNumbers)
			}
		})
	}
}

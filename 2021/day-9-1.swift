#!/usr/bin/swift sh

import Foundation

let inputFilename = "day-9-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

var height = lines.count
var width = lines[0].count
var storage: [Int] = []

for line in lines {
    for char in line {
        if char == "\n" { continue }
        storage.append(Int(String(char))!)
    }
}

// returns the value at row/column
func at(_ row: Int, _ column: Int) -> Int? {
    if row < 0 || row >= height { return nil }
    if column < 0 || column >= width { return nil }

    let index = column + row * width
    return storage[index]
}

//  A
// BXC
//  D
func isLowPoint(_ row: Int, _ column: Int) -> Bool {
    guard let rootValue = at(row, column) else { return false }

    if let v = at(row - 1, column) { // A
        if rootValue >= v { return false }
    }

    if let v = at(row, column - 1) { // B
        if rootValue >= v { return false }
    }

    if let v = at(row, column + 1) { // C
        if rootValue >= v { return false }
    }

    if let v = at(row + 1, column) { // D
        if rootValue >= v { return false }
    }

    return true
}

var score = 0
for column in 0 ..< width {
    for row in 0 ..< height {
        if isLowPoint(row, column) {
            print("found at \(row) \(column) has \(at(row, column)!)")
            score += at(row, column)! + 1
        }
    }
}

print("score \(score)")

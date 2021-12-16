#!/usr/bin/swift

import Foundation

let inputFilename = "day-11-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

let width = 10
let height = 10

var storage: [Int] = []

for line in lines {
    for char in line {
        storage.append(Int(String(char))!)
    }
}

var flashCount = 0

func set(_ value: Int, _ row: Int, _ column: Int) {
    let index = column + row * width
    storage[index] = value
}

func at(_ row: Int, _ column: Int) -> Int? {
    if row < 0 || row >= height { return nil }
    if column < 0 || column >= width { return nil }
    let index = column + row * width
    return storage[index]
}

func flash(_ row: Int, _ column: Int) {
    flashCount += 1
    set(-1, row, column)

    for r in row - 1 ... row + 1 {
        for c in column - 1 ... column + 1 {
            increment(r, c)
        }
    }
}

func increment(_ row: Int, _ column: Int) {
    guard var current = at(row, column) else { return }
    if current == -1 { return } // already flashed

    current += 1

    if current == 10 { // flash
        flash(row, column)
    } else {
        set(current, row, column)
    }
}

func step() {
    for row in 0 ..< height {
        for column in 0 ..< width {
            increment(row, column)
        }
    }

    for row in 0 ..< height {
        for column in 0 ..< width {
            if at(row, column) == -1 {
                set(0, row, column)
            }
        }
    }
}

func pretty(blah: [Int]) {
    for row in 0 ..< height {
        for column in 0 ..< width {
            print("\(at(row, column)!)", terminator: "")
        }
        print("")
    }
}

func allFlashed() -> Bool {
    if storage.filter { $0 == 0 }.count == storage.count {
        return true
    }
    return false
}

for i in 1 ... 2000 {
    step()
    if allFlashed() {
        print("flashy step \(i)")
        break
    }
}

pretty(blah: storage)
print("score \(flashCount)")

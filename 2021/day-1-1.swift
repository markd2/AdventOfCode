#!/usr/bin/swift

import Foundation

let inputFilename = "day-1-1-prod.txt"

let input = try! String(contentsOfFile: inputFilename)

let lines = input.split(separator: "\n")

let ints = lines.map { Int($0)! }

var increases = 0

for i in 1 ..< ints.count {
    if ints[i] > ints[i-1] {
        increases += 1
    }
}

print("increases \(increases) for \(ints.count) items")


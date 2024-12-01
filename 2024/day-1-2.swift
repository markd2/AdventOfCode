#!/usr/bin/swift -enable-bare-slash-regex
import Foundation
import RegexBuilder

//let inputFilename = "day-1-test.txt"
let inputFilename = "day-1-prod.txt"

let input = try! String(contentsOfFile: inputFilename, encoding: .utf8)
let lines = input.split(separator: "\n")

let pattern = /(\d+) *(\d+)/

var col1: [Int] = []
var col2Count = NSCountedSet()

for line in lines {
    if let result = try? pattern.wholeMatch(in: line) {
        col1.append(Int(result.1)!)
        col2Count.add(Int(result.2)!)
    }
} 

print(col2Count, col2Count.count(for: 3))

let similarity =  col1.reduce(0) { $0 + ($1 * col2Count.count(for: $1)) }
print(similarity)


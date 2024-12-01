#!/usr/bin/swift -enable-bare-slash-regex
import Foundation
import RegexBuilder

//let inputFilename = "day-1-test.txt"
let inputFilename = "day-1-prod.txt"

let input = try! String(contentsOfFile: inputFilename, encoding: .utf8)
let lines = input.split(separator: "\n")

let pattern = /(\d+) *(\d+)/

var col1: [Int] = []
var col2: [Int] = []

for line in lines {
    if let result = try? pattern.wholeMatch(in: line) {
        col1.append(Int(result.1)!)
        col2.append(Int(result.2)!)
    }
} 

let sum = zip(col2.sorted(), col1.sorted()).reduce(0) { $0 + abs($1.1 - $1.0) }
print(sum)

#!/usr/bin/swift sh
import Foundation
import Algorithms // https://github.com/apple/swift-algorithms ~> 1.0.0

let inputFilename = "day-1-1-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

let ints = lines.map { Int($0)! }
var increases = 0

let pairs = ints.adjacentPairs()

increases = pairs
  .filter { (oldFleems, newFleems) in return newFleems > oldFleems }
  .count

print("increases \(increases) for \(ints.count) items")


#!/usr/bin/swift sh
import Foundation
import Algorithms // https://github.com/apple/swift-algorithms ~> 1.0.0

let inputFilename = "day-2-1-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

// we control the
var horizontal = 0
// we control the
var vertical = 0

for line in lines {
    let chunks = line.split(separator: " ")
    guard chunks.count == 2,
          let value = Int(chunks[1]) else {
        print("argh: \(line)")
        break
    }
    switch chunks[0] {
    case "forward":
        horizontal += value
    case "down":
        vertical += value
    case "up":
        vertical -= value
    default:
        print("argh: \(line)")
    }
}

print("got h/v \(horizontal) \(vertical)")
let solution = horizontal * vertical
print("mutiplied \(solution)")

#!/usr/bin/swift sh
import Foundation
import Algorithms // https://github.com/apple/swift-algorithms ~> 1.0.0

let inputFilename = "day-3-1-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

let bitcount = lines[0].count
let totalLines = lines.count
var buckets: [Int] = Array(repeating: 0, count: bitcount)

// Count number of 1 bits in each position
lines.forEach { line in
    for (i, character) in line.enumerated() {
        buckets[i] += (character == "1") ? 1 : 0
    }
}

// reduce

var epsilon: UInt = 0
var gamma: UInt = 0
for i in 0 ..< bitcount {
    if buckets[bitcount - i - 1] > totalLines / 2 {
        epsilon |= 1 << i
    } else {
        gamma |= 1 << i
    }
}

let result = epsilon * gamma

print("buckets \(buckets), epsilon \(epsilon) \(String(epsilon, radix: 2))  gamma \(gamma) \(String(gamma, radix: 2))  result \(result)")


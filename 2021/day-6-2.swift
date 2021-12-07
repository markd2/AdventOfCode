#!/usr/bin/swift
import Foundation

let inputFilename = "day-6-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

let fishies = lines[0].split(separator: ",").compactMap { Int($0) }

print("so many fishies \(fishies.count)")

var ageCounts: [Int] = Array(repeating: 0, count: 9) // 0 through 8

for fish in fishies {
    ageCounts[fish] += 1
}

var day = 0
let finalDay = 256

while true {
    // wow.  Swift won't let us popFirst an int array :-(
    // https://bugs.swift.org/browse/SR-11555
    // let zeroCount = ageCounts.popFirst() ?? 0
    let zeroCount = ageCounts[0]
    ageCounts.removeFirst()

    ageCounts[6] += zeroCount
    ageCounts.append(zeroCount)

    day += 1
    if day >= finalDay { break }
}

let allOfThem = ageCounts.reduce(0, +)

print("so many fishes \(ageCounts) left in the sea, but only \(allOfThem) for Londo and me")

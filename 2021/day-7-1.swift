#!/usr/bin/swift sh
import Foundation
//import Algorithms // https://github.com/apple/swift-algorithms ~> 1.0.0

let inputFilename = "day-7-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

let crabbage = lines[0].split(separator: ",").compactMap { Int($0) }.sorted()

let minCrab = crabbage.first!
let maxCrab = crabbage.last!
print("crabbage from \(minCrab) to \(maxCrab)")


func fuelCost(position: Int, army: [Int]) -> Int{
    army.reduce(0, { $0 + abs($1 - position) })
}


var minFuelCost = Int.max
var minFuelCostPosition = 0

for position in minCrab ... maxCrab {
    let flarnge = fuelCost(position: position, army: crabbage)
    if flarnge < minFuelCost {
        minFuelCost = flarnge
        minFuelCostPosition = position
    }
}

print("min fuel of \(minFuelCost) at \(minFuelCostPosition)")

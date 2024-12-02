#!/usr/bin/swift -enable-bare-slash-regex
import Foundation
import RegexBuilder

//let inputFilename = "day-2-test.txt"
let inputFilename = "day-2-prod.txt"

let input = try! String(contentsOfFile: inputFilename, encoding: .utf8)
let lines = input.split(separator: "\n")


var safeCount = 0

for line in lines {
    let values = line.split(separator: " ").map { String($0) }.compactMap { Int($0) }
     if applyRules(to: values) {
        safeCount += 1
    }
} 

print(safeCount)

func applyRules(to values: [Int]) -> Bool {
    enum Direction {
        case increasing
        case decreasing
        case huh
    }
    var direction = Direction.huh
    var lastNumber: Int? = nil
    print("----------")
    print("looking at \(values)")

    for value in values {
        defer { lastNumber = value }
        print("looking at \(value)")

        let diff = abs(value - (lastNumber ?? 0))
        print("    diff \(diff)")

        switch direction {
        case .increasing:
            guard let lastNumber else {
                print("    increasing yet no last number. weird")
                return false
            }
            if value <= lastNumber {
                print("    started decreasing. bailing")
                return false
            }
            if diff < 1 || diff > 3 {
                print("    exceeds safety margin - \(diff)")
                return false
            }
        case .decreasing:
            guard let lastNumber else {
                print("    decreasing yet no last number. weird")
                return false
            }
            if value >= lastNumber {
                print("    started increasing \(value) <= \(lastNumber). bailing")
                return false
            }
            if diff < 1 || diff > 3 {
                print("    exceeds safety margin - \(diff)")
                return false
            }
        case .huh:
            if let last = lastNumber {
                lastNumber = last
                if last < value {
                    direction = .increasing
                    print("    switching to increasing")
                } else if last > value {
                    direction = .decreasing
                    print("    switching to decreasing")
                } else {
                    print("    first two equal.  bailing")
                    return false
                }

                if diff < 1 || diff > 3 {
                    print("    exceeds safety margin - \(diff)")
                    return false
                }
            }
        }
    }
    print("YAY!")
    return true
}

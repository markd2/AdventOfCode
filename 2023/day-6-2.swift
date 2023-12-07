#!/usr/bin/swift sh
import Foundation
import RegexBuilder

//let inputFilename = "day-6-1-test.txt"
let inputFilename = "day-6-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

struct Race {
    let raceTime: Int       // ms
    let recordDistance: Int // mm

    func distanceForTime(_ holdTime: Int) -> Int {
        let effectiveTime = raceTime - holdTime
        guard effectiveTime > 0 else { return 0 }
        let distance = holdTime * effectiveTime
        return distance
    }

    func waysToWin() -> Int {
        var count = 0
        for time in 0 ... raceTime {
            let distance = distanceForTime(time)
            if distance > recordDistance {
                count += 1
            }
        }
        return count
    }
}

let time = lines[0].filter{!$0.isWhitespace}.split(separator: ":").compactMap { Int($0) }
let distance = lines[1].filter{!$0.isWhitespace}.split(separator: ":").compactMap { Int($0) }

print(time)
print(distance)

let races = zip(time, distance).map { Race(raceTime: $0, recordDistance: $1) }
print(races)

let winnersIsYou = races.map { $0.waysToWin() }
print(winnersIsYou)

let marginOfError = winnersIsYou.reduce(1, *)
print(marginOfError)

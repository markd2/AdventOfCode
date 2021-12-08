#!/usr/bin/swift -O
// ^^^ notice that it needs -O.  Using debug swift results in multi-minute runtimes.x

import Foundation

let inputFilename = "day-8-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

struct Display {
    let signalPatterns: [String]
    let outputValue: [String]

    init(_ string: String) {
        let coarseChunks = string.split(separator: "|")
        
        signalPatterns = coarseChunks[0].split(separator: " ").map { String($0) }
        if signalPatterns.count != 10 {
            print("oops \(coarseChunks[0])")
        }
        
        outputValue = coarseChunks[1].split(separator: " ").map { String($0) }
        if outputValue.count != 4 {
            print("oops \(coarseChunks[1])")
        }
    }

    func count1478() -> Int {
        let blah = outputValue.filter {
            switch $0.count {
            case 2: // 1
                return true
            case 4: // 4
                return true
            case 3: // 7
                return true
            case 7: // 8
                return true
            default:
                return false
            }
        }
        print("\(blah.count) -> \(outputValue)")
        return blah.count
    }
}

var entries: [Display] = []

for line in lines {
    let display = Display(String(line))
    entries.append(display)
}


var sum = 0
for entry in entries {
    sum += entry.count1478()
}

print("huh \(sum)")

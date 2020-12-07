#!/usr/bin/env swift

import Foundation

// let fileURL = URL(string: "file:///Users/markd/Projects/AdventOfCode/2020/day-7-test-input.txt")!
let fileURL = URL(string: "file:///Users/markd/Projects/AdventOfCode/2020/day-7-input.txt")!
let string = try! String(contentsOf: fileURL, encoding: .utf8)

let lines = string.split(separator: "\n")

// of the form
//     dark orange -> [bright white, muted yellow]
// dark orange can contain bright white or muted yellow
var containsTable: [String : Set<String>] = [:]

// of the form
//    bright white -> [light red, dark orange, root]
// bright white can directly live inside of light red, dark orange, 
// or can be a top-level bag
var reverseTable: [String : Set<String>] = [:]

for line in lines {
    let chunks = line.split(separator: " ")
    if (chunks.count < 7) {
        print("insufficient line \(line)")
        continue
    }

    // dark orange bags contain 3 bright white bags, 4 muted yellow bags.

    // _dark orange bags"
    let lhs = chunks[0] + " " + chunks[1]
    print("key \(lhs)")

    // bags
    _ = chunks[2]

    // contain(s)
    _ = chunks[3]

    // 3
    _ = chunks[4]

    var blah = containsTable[String(lhs)] ?? Set<String>()

    for i in stride(from: 5, through: chunks.count, by: 4) {
        let rhs: String

//        print("LOOKING AT \(chunks[i]) \(chunks[i+1])")

        if chunks[i] == "other" && (chunks[i+1] == "bags." || chunks[i+1] == "bag.") {
            continue
        } else {
            rhs = chunks[i] + " " + chunks[i + 1]
        }

//        print("    value \(rhs)")

        var teleblah = reverseTable[rhs] ?? Set<String>()
        teleblah.insert(String(lhs))
        reverseTable[rhs] = teleblah

        blah.insert(rhs)
    }
    containsTable[String(lhs)] = blah

}
print("SPLUNGE \(reverseTable)")

// now to process

var accumulator = Set<String>()

func grepBag(table: [String: Set<String>], lookingFor: String) {
    accumulator.insert(lookingFor)

    guard let found = table[lookingFor] else {
        print("bailing out")
        return
    }

    print("found \(found)")

    for thing in found {
        grepBag(table: table, lookingFor: thing)
    }
}

grepBag(table: reverseTable, lookingFor: "shiny gold")
print("found")
print(accumulator)
print("TOTAL ", accumulator.count - 1)




#!/usr/bin/env swift

import Foundation

// let fileURL = URL(string: "file:///Users/markd/Projects/AdventOfCode/2020/day-7-test-input-2.txt")!
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

struct BagGazinta: Hashable {
    let name: String
    let count: Int
}
// of the form
//    shiny gold -> [2 dark red]
//    dark orange -> [3 bright white, 4 muted yellow]

var bagOfHoldingTable: [String: [BagGazinta]] = [:]

for line in lines {
    let chunks = line.split(separator: " ")
    if (chunks.count < 7) {
        print("insufficient line \(line)")
        continue
    }

    // dark orange bags contain 3 bright white bags, 4 muted yellow bags.

    // _dark orange bags"
    let lhs = chunks[0] + " " + chunks[1]
//    print("key \(lhs)")

    // bags
    _ = chunks[2]

    // contain(s)
    _ = chunks[3]

    var blah = containsTable[String(lhs)] ?? Set<String>()

    for i in stride(from: 4, through: chunks.count-1, by: 4) {
        let rhs: String

        let count = Int(chunks[i]) ?? 0

//        print("LOOKING AT \(chunks[i+1]) \(chunks[i+2])")

        if chunks[i+1] == "other" && (chunks[i+2] == "bags." || chunks[i+2] == "bag.") {
            bagOfHoldingTable[String(lhs)] = []
            continue
        } else {
            rhs = chunks[i+1] + " " + chunks[i + 2]
        }

        let gazinta = BagGazinta(name: String(rhs), count: count)
        var splunge = bagOfHoldingTable[String(lhs)] ?? []

        splunge += [gazinta]
        bagOfHoldingTable[String(lhs)] = splunge

//        print("    value \(rhs)")

        var teleblah = reverseTable[rhs] ?? Set<String>()
        teleblah.insert(String(lhs))
        reverseTable[rhs] = teleblah

        blah.insert(rhs)
    }
    containsTable[String(lhs)] = blah

}
// print("SPLUNGE \(reverseTable)")

// now to process

var accumulator = Set<String>()

func grepBag(table: [String: Set<String>], lookingFor: String) {
    accumulator.insert(lookingFor)

    guard let found = table[lookingFor] else {
//        print("bailing out")
        return
    }

//    print("found \(found)")

    for thing in found {
        grepBag(table: table, lookingFor: thing)
    }
}

grepBag(table: reverseTable, lookingFor: "shiny gold")
// print("found")
// print(accumulator)
print("TOTAL (part 1) ", accumulator.count - 1)

//print(bagOfHoldingTable)
var depth = 0

func countBags(_ name: String) -> Int {
    depth += 1
    var sum = 1 // count us

    let indent = String(repeating: " ", count: depth * 3)

    // How manuy bags must be inside of this?
    let gazintae = bagOfHoldingTable[name]!
//    print(indent, "looking at \(name)")

    for gazinta in gazintae {
        for i in 0 ..< gazinta.count {
            sum += countBags(gazinta.name)
        }
    }

//    print(indent, " -> \(sum)")

    depth -= 1
    return sum
}

let amazon = countBags("shiny gold") - 1  // don't count the shiny gold bag itself

print("grand bag \(amazon)")

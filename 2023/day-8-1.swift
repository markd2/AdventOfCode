#!/usr/bin/swift sh
import Foundation

//let inputFilename = "day-8-1-test.txt"
let inputFilename = "day-8-1-test-2.txt"
//let inputFilename = "day-8-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

struct NodePair {
    let left: String
    let right: String
}

var graph: [String: NodePair] = [:]

let instructions = Array(lines[0])

var trimset = CharacterSet(charactersIn: " ()")

for line in lines {
    var oop = line
    oop.unicodeScalars.removeAll(where: { trimset.contains($0) })

    let blah = oop.split(separator: "=")
    if blah.count < 2 { continue }
    let key = String(blah[0])
    let blah2 = blah[1].split(separator: ",")
    let nodePair = NodePair(left: String(blah2[0]), right: String(blah2[1]))
    
    if graph[key] != nil {
        print("oops - duplicate key \(key)")
    }
    graph[key] = nodePair
}

var currentNode = "AAA"
let terminalNode = "ZZZ"
var stepCount = 0
var pc = 0

while true {
    stepCount += 1
    let instruction = instructions[pc]
    pc = (pc + 1) % instructions.count

    guard let pair = graph[currentNode] else {
        print("did not find graph entry for \(currentNode)")
        break
    }
    print("looking at \(currentNode), got \(pair), instruction \(instruction)")

    if instruction == "L" {
        currentNode = pair.left
    } else if instruction == "R" {
        currentNode = pair.right
    } else {
        print("bad instruction: \(instruction)")
    }

    if currentNode == terminalNode {
        print("breaking \(currentNode) \(terminalNode)")
        break
    }
}

print(stepCount)

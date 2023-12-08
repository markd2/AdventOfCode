#!/usr/bin/swift sh
import Foundation

//let inputFilename = "day-8-1-test.txt"
//let inputFilename = "day-8-1-test-2.txt"
//let inputFilename = "day-8-2-test.txt"
let inputFilename = "day-8-prod.txt"

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

class CPUCore {
    var pc = 0

    let startingNode: String

    var currentNode: String = ""

    var isDone: Bool {
        return currentNode.last! == "Z"
    }

    init(startingNode: String) {
        self.startingNode = startingNode
        self.currentNode = startingNode
    }

    func step() {
        let instruction = instructions[pc]
        pc = (pc + 1) % instructions.count

        guard let pair = graph[currentNode] else {
            print("did not find graph entry for \(currentNode)")
            return
        }

        if instruction == "L" {
            currentNode = pair.left
        } else if instruction == "R" {
            currentNode = pair.right
        } else {
            print("bad instruction: \(instruction)")
        }
    }
}

var ripper: [CPUCore] = []

for key in graph.keys {
    if key.last == "A" {
        let core = CPUCore(startingNode: key)
        ripper.append(core)
    }
}

var count = 0
while true {
    count += 1
    ripper.forEach { $0.step() }

    let blah = ripper.filter{ !$0.isDone }
    if blah.count == 0 { break }

    if count % 1000000 == 0 {
        print("count \(count)")
    }

}

print(count)


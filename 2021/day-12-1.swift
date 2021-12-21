#!/usr/bin/swift

import Foundation

let inputFilename = "day-12-test.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

class Node: CustomStringConvertible {
    let label: String
    var visited: Bool

    init(label: String) {
        self.label = label
        self.visited = false
    }

    var description: String {
        return "(\"\(label)\", \(visited))"
    }
}

struct Stack<T> {
    private var storage: [T] = []

    var depth: Int {
        storage.count
    }

    mutating func push(_ element: T) {
        storage.append(element)
    }
    
    mutating func pop() -> T? {
        storage.popLast()
    }

    mutating func clear() {
        storage = []
    }
}

var graph: [String: [Node]] = [:]

for line in lines {
    let chunks = line.split(separator: "-")

    let thing1 = String(chunks[0])
    let thing2 = String(chunks[1])

    var blah = graph[thing1] ?? []
    blah.append(Node(label: thing2))
    graph[thing1] = blah

    blah = graph[thing2] ?? []
    blah.append(Node(label: thing1))
    graph[thing2] = blah
}

print(graph)

var stack = Stack<Node>()

let startNode = graph["start"].first!

func visit(startNode) {
    stack.push(startNode)
...
}

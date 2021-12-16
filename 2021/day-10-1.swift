#!/usr/bin/swift

import Foundation

let inputFilename = "day-10-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

struct Stack {
    private var storage: [String] = []

    var depth: Int {
        storage.count
    }

    mutating func push(_ element: String) {
        storage.append(element)
    }
    
    mutating func pop() -> String? {
        storage.popLast()
    }

    mutating func clear() {
        storage = []
    }
}

var stack = Stack()

var score = 0

for line in lines {
    for char in line {
        let blah = String(char)
        switch blah {
        case "(", "[", "{", "<":
            stack.push(blah)
        case ")":
            let last = stack.pop()
            if last != "(" {
                print("MISMATCH )")
                score += 3
            }
        case "]":
            let last = stack.pop()
            if last != "[" {
                print("MISMATCH ]")
                score += 57
            }
        case "}":
            let last = stack.pop()
            if last != "{" {
                print("MISMATCH }")
                score += 1197
            }
        case ">":
            let last = stack.pop()
            if last != "<" {
                print("MISMATCH >")
                score += 25137
            }
        default:
            print("WHA? \(blah)")
        }
    }
    if stack.depth != 0 {
        print("INCOMPLETE")
    }
    stack.clear()
}

print("score \(score)")



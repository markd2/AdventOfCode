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

var incompleties: [Int] = []

for line in lines {
    var mismatch = false
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
                mismatch = true
            }
        case "]":
            let last = stack.pop()
            if last != "[" {
                print("MISMATCH ]")
                score += 57
                mismatch = true
            }
        case "}":
            let last = stack.pop()
            if last != "{" {
                print("MISMATCH }")
                score += 1197
                mismatch = true
            }
        case ">":
            let last = stack.pop()
            if last != "<" {
                print("MISMATCH >")
                score += 25137
                mismatch = true
            }
        default:
            print("WHA? \(blah)")
        }
    }

    if !mismatch && stack.depth != 0 {
        var incompleteScore = 0
        print("INCOMPLETE")
        while let blah = stack.pop() {
            incompleteScore *= 5
            switch blah {
            case "(":
                incompleteScore += 1
            case "[":
                incompleteScore += 2
            case "{":
                incompleteScore += 3
            case "<":
                incompleteScore += 4
            default:
                print("WHAA? \(blah)")
            }
        }
        print("incomplete score \(incompleteScore)")
        incompleties.append(incompleteScore)
    }
    stack.clear()
}

incompleties.sort { $0 < $1 }

print("middle is \(incompleties[incompleties.count / 2])")

print("mismatch score \(score)")



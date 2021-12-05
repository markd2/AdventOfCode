#!/usr/bin/swift sh
import Foundation
//import Algorithms // https://github.com/apple/swift-algorithms ~> 1.0.0

let inputFilename = "day-4-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

class Board {
    let width = 5
    let height = 5
    var storage: [Int] = []
    var seen: [Bool] = []

    init(_ values: [Int]) {
        self.storage = values
        self.seen = Array(repeating: false, count: values.count)
        print("values count? \(values.count)")
    }

    private func valueAt(row: Int, column: Int) -> Int {
        let index = column + row * width
        return storage[index]
    }

    private func seenValue(_ row: Int, _ column: Int) -> Bool {
        let index = column + row * width
        return seen[index]
    }

    func visit(value: Int) {
        // We could sort and binary search, but wait until we measure a real
        // performance problem
        for (i, boardValue) in storage.enumerated() {
            if boardValue == value {
                seen[i] = true
            }
        }
    }

    func aWinnerIsMe() -> Bool {
        // check rows

        for row in 0 ..< height {
            var squaresSeen = 0
            for column in 0 ..< width {
                if seenValue(row, column) {
                    squaresSeen += 1
                }
            }
            
            if squaresSeen == 5 {
                print("a winner is me on row \(row)")
                return true
            }
        }

        // check columns
        for column in 0 ..< width {
            var squaresSeen = 0
            for row in 0 ..< height {
                if seenValue(row, column) {
                    squaresSeen += 1
                }
            }
            
            if squaresSeen == 5 {
                print("a winner is me on column \(column)")
                return true
            }
        }
        return false
    }

    func score(withDraw: Int) -> Int {
        var unseenSum = 0
        
        for (value, sawIt) in zip(storage, seen) {
            if !sawIt {
                unseenSum += value
            }
        }
        print("unseenmly \(unseenSum)")
        let score = unseenSum * withDraw
        return score
    }

    func dump() {
        print(storage)
        print(seen)
    }
}

let draws = lines[0].split(separator: ",").compactMap { Int(String($0)) }

var i = 1

var boards: [Board] = []

while i < lines.count - 1 {
    var boardValues: [Int] = []
    for _ in 0 ..< 5 {
        boardValues += lines[i].split(separator:" ").compactMap { Int(String($0)) }
        i += 1
    }
    if boardValues.count != 25 {
        print("OH NOES \(i) \(boardValues.count)")
    }
    boards.append(Board(boardValues))
}

print("found \(boards.count) boards")

blah: for draw in draws {
    print("DRAWING \(draw)")
    for board in boards {
        board.visit(value: draw)
        if board.aWinnerIsMe() {
            let score = board.score(withDraw: draw)
            print("WOOT  got a winner with score \(score)")
            board.dump()
            break blah
        }
    }
}

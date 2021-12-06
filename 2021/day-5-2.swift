#!/usr/bin/swift sh
import Foundation
//import Algorithms // https://github.com/apple/swift-algorithms ~> 1.0.0

let inputFilename = "day-5-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

struct Point {
    let row: Int
    let column: Int
    
    // of the form 12,34 (col, row)
    init(string: String) {
        let chunks = string.split(separator: ",")
        self.column = Int(chunks[0])!
        self.row = Int(chunks[1])!
    }
    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }
}

struct Line {
    let thing1: Point
    let thing2: Point

    var isHorizontal: Bool {
        thing1.row == thing2.row
    }
    
    var isVertical: Bool {
        thing1.column == thing2.column
    }

    var isDiagonal: Bool {
        !isHorizontal && !isVertical
    }
}

class World {
    var width: Int
    var height: Int
    private var counts: [Int]

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        self.counts = Array(repeating: 0, count: width * height)
    }

    func apply(_ line: Line) {

        if line.isHorizontal {
            let row = line.thing1.row
            let startColumn = min(line.thing1.column, line.thing2.column)
            let stopColumn = max(line.thing1.column, line.thing2.column)

            for column in startColumn ... stopColumn {
                let index = column + row * width
                counts[index] += 1
            }
            
        } else if line.isVertical {
            let column = line.thing1.column
            let startRow = min(line.thing1.row, line.thing2.row)
            let stopRow = max(line.thing1.row, line.thing2.row)

            for row in startRow ... stopRow {
                let index = column + row * width
                counts[index] += 1
            }

        } else if line.isDiagonal {
            let startRow = line.thing1.row
            let startColumn = line.thing1.column
            let stopRow = line.thing2.row
            let stopColumn = line.thing2.column

            if abs(startRow - stopRow) != abs(startColumn - stopColumn) {
                print("INVARIANT FAIL \(line)")
            }

            let rowIncrement = startRow > stopRow ? -1 : 1
            let columnIncrement = startColumn > stopColumn ? -1 : 1

            var row = startRow
            var column = startColumn
            let count = abs(startRow - stopRow)

            for i in 0...count {
                let index = column + row * width
                counts[index] += 1
                row += rowIncrement
                column += columnIncrement
            }
        }
    }

    func overlapCountAt(_ row: Int, _ column: Int) -> Int {
        let index = column + row * width
        return counts[index]
    }

    func dump() {
        for row in 0 ..< height {
            for column in 0 ..< width {
                let index = column + row * width
                print("\(counts[index])", terminator: "")
            }
            print("")
        }
    }
}

var width = 0
var height = 0  
var dangerLines: [Line] = []

for line in lines {
    let chunks = String(line).split(separator: " ")
    if chunks.count != 3 {
        print("blarg \(line)")
    }
    let point1 = Point(string: String(chunks[0]))
    let point2 = Point(string: String(chunks[2]))

    width = max(width, point1.column)
    height = max(height, point1.row)
    width = max(width, point2.column)
    height = max(height, point2.row)

    let dangerLine = Line(thing1: point1, thing2: point2)
    dangerLines.append(dangerLine)
}

let world = World(width: width + 1, height: height + 1)

for dangerLine in dangerLines {
    world.apply(dangerLine)
}


// find the spots
var dangerousAreaCount = 0

for row in 0 ... height {
    for column in 0 ... width {
        let overlapCount = world.overlapCountAt(row, column)
        if overlapCount >= 2 {
            dangerousAreaCount += 1
        }
    }
}

print("count \(dangerousAreaCount)")


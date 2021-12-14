#!/usr/bin/swift sh

import Foundation

let inputFilename = "day-9-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

var height = lines.count
var width = lines[0].count
var storage: [Int] = []

struct Point: Hashable {
    let row: Int
    let column: Int

    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }

    var up: Point? {
        Point(row - 1, column)
    }

    var down: Point? {
        Point(row + 1, column)
    }

    var left: Point? {
        Point(row, column - 1)
    }

    var right: Point? {
        Point(row, column + 1)
    }

    var isMineANinetyNine: Bool {
        guard let value = at(row, column) else { return false }
        return value == 9
    }

    func isValid(_ rows: Int, _ columns: Int) -> Bool {
        if row < 0 { return false }
        if column < 0 { return false }
        if row >= rows { return false }
        if column >= columns { return false }

        return true
    }
}

for line in lines {
    for char in line {
        if char == "\n" { continue }
        storage.append(Int(String(char))!)
    }
}

// returns the value at row/column
func at(_ row: Int, _ column: Int) -> Int? {
    if row < 0 || row >= height { return nil }
    if column < 0 || column >= width { return nil }

    let index = column + row * width
    return storage[index]
}

//  A
// BXC
//  D
func isLowPoint(_ row: Int, _ column: Int) -> Bool {
    guard let rootValue = at(row, column) else { return false }

    if let v = at(row - 1, column) { // A
        if rootValue >= v { return false }
    }

    if let v = at(row, column - 1) { // B
        if rootValue >= v { return false }
    }

    if let v = at(row, column + 1) { // C
        if rootValue >= v { return false }
    }

    if let v = at(row + 1, column) { // D
        if rootValue >= v { return false }
    }

    return true
}



func glom(_ point: Point, into glorp: inout Set<Point>) {
    if glorp.contains(point) { return }

    glorp.insert(point)

    // look at neighbors
    for point in [point.up, point.down, point.left, point.right] {
        guard let p = point, p.isValid(height, width) else { continue }
        if p.isMineANinetyNine {
            glorp.insert(p)
        } else {
            glom(p, into: &glorp)
        }
    }
}

var basinSizes: [Int] = []

snarnge: for column in 0 ..< width {
    for row in 0 ..< height {
        if isLowPoint(row, column) {
            var glorp: Set<Point> = []
            print("found at \(row) \(column) has \(at(row, column)!)")
            
            glom(Point(row, column), into: &glorp)

            let nork = glorp.filter{ p in return !p.isMineANinetyNine }
            basinSizes.append(nork.count)

/* print out board
            for r in 0 ..< height {
                for c in 0 ..< width {
                    let greeble = Point(r, c)
                    if nork.contains(greeble) {
                        print(".", terminator: "")
                    } else {
                        print("\(at(r, c)!)", terminator: "")
                    }
                }
                print("")
            }
*/
        }
    }
}

basinSizes.sort{ $0 > $1 }
let score = basinSizes[0] * basinSizes[1] * basinSizes[2]

print("score \(score)")

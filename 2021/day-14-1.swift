#!/usr/bin/swift

import Foundation

let inputFilename = "day-14-test.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

struct Point {
    let row: Int
    let column: Int

    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
    }

}

struct Fold {
    enum Axis {
        case foldUp
        case foldLeft
    }
    let axis: Axis
    let offset: Int

    init(_ string: String) {
        let chunks = string.split(separator: "=")
        switch chunks[0] {
        case "x":
            axis = .foldLeft
        case "y":
            axis = .foldUp
        default:
            print("HUH \(string)")
            axis = .foldUp
        }
        offset = Int(chunks[1])!
    }
}

var points: [Point] = []
var folds: [Fold] = []
var width = 0
var height = 0

for line in lines {
    print(line)
    if line.hasPrefix("fold along") {
        let chunks = line.split(separator: " ") // fold along x=23
        let fold = Fold(String(chunks[2]))
        folds.append(fold)
    } else {
        let chunks = line.split(separator: ",") // 5,666
        if chunks.count != 2 { continue }
        let row = Int(chunks[0])!
        let column = Int(chunks[1])!
        width = max(width, column)
        height = max(height, row)
        let point = Point(row, column)
        points.append(point)
    }
}

func prettyPrint(_ storage: [String], _ width: Int, _ height: Int) {
    for column in 0 ..< width {
        for row in 0 ..< height {
            let index = column + row * width
            print(storage[index], terminator: "")
        }
        print("")
    }
}

width += 1
height += 1

var storage: [String] = Array(repeating: ".", count: width * height)

prettyPrint(storage, width, height)

func set(_ string: String, _ row: Int, _ column: Int) {
    let index = column + row * width
    storage[index] = string
}

func set(_ string: String, _ point: Point) {
    set(string, point.row, point.column)
}

for point in points {
    set("#", point)
}
print("----------")
prettyPrint(storage, width, height)

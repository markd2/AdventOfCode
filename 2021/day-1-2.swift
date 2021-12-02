#!/usr/bin/swift sh
import Foundation
import Algorithms // https://github.com/apple/swift-algorithms ~> 1.0.0

import Foundation

let inputFilename = "day-1-1-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

let ints = lines.map { Int($0)! }

if true {
    var increases = 0

    increases = ints.windows(ofCount: 3)
      .map(\.sum)
      .adjacentPairs()
      .filter { (oldFleems, newFleems) in 
          return newFleems > oldFleems }
      .count

    print("increases \(increases) for three-fold \(ints.count) items")

} else {
    var threeFoldInts: [Int] = []
    
    for i in 2 ..< ints.count {
        let sum = ints[i] + ints[i-1] + ints[i-2]
        threeFoldInts.append(sum)
    }


    func increasesFor(ints: [Int]) -> Int {
        var increases = 0
        
        for i in 1 ..< ints.count {
            if ints[i] > ints[i-1] {
                increases += 1
            }
        }
        return increases
    }
    
    let increases = increasesFor(ints: threeFoldInts)
    print("increases \(increases) for three-fold \(ints.count) items")
}


extension Sequence where Element: Numeric {
    var sum: Element {
        var sum: Element = 0
        forEach { blah in
            sum += blah
        }
        return sum
    }
}

#!/usr/bin/swift sh
import Foundation
import RegexBuilder

let inputFilename = "day-3-1-test.txt"
// let inputFilename = "day-3-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

let xnumbers = Regex {
    OneOrMore(.digit)
}

let numbersRe = "[0-9]+"
let symbolsRe = "[^0-9.]"

struct Number {
    let number: Int
    let line: Int
    let anchor: Int
}

struct Symbol {
    let symbol: String
    let line: Int
    let anchor: Int
}

var numbers: [Number] = []
var symbols: [Symbol] = []

for (index, line) in lines.enumerated() {
    // numbers
    do {
        let regex = try NSRegularExpression(pattern: numbersRe)
        let results = regex.matches(in: String(line),
                                    range: NSRange(line.startIndex..., in: line))
        let lineNumbers = results.map {
            let match = String(line[Range($0.range, in: line)!])
            let nombre = Int(match)!
            let number = Number(number: nombre, line: index, 
                                anchor: $0.range.location)
            return number
        }
        numbers = (numbers + lineNumbers).flatMap{ $0 }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
    }

    do {
        let regex = try NSRegularExpression(pattern: symbolsRe)
        let results = regex.matches(in: String(line),
                                    range: NSRange(line.startIndex..., in: line))
        let lineSymbols = results.map {
            let match = String(line[Range($0.range, in: line)!])
            let symbol = Symbol(symbol: match, line: index, 
                                anchor: $0.range.location)
            return symbol
        }
        symbols = (symbols + lineSymbols).flatMap{ $0 }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
    }
}
print(numbers)
print(symbols)

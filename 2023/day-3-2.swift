#!/usr/bin/swift sh
import Foundation
import RegexBuilder

//let inputFilename = "day-3-1-test.txt"
let inputFilename = "day-3-prod.txt"

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

var numbers: [Int: [Number] ] = [:]
var symbols: [Int: [Symbol] ] = [:]

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
        numbers[index] = lineNumbers
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
        symbols[index] = lineSymbols
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
    }
}
//print(numbers)
//print(symbols)

func hasAdjacentSymbol(_ number: Number) -> Bool {
    let above = symbols[number.line - 1]
    let this = symbols[number.line]
    let below = symbols[number.line + 1]
    let all = (this ?? []) + (above ?? []) + (below ?? [])

    let numberLength = Int(trunc(log10(Double(number.number))))

    let range = (number.anchor-1)...(number.anchor + numberLength + 1)
    for symbol in all {
        if range.contains(symbol.anchor) {
            return true
        }
    }
    return false
}

func adjacentsTo(_ symbol: Symbol) -> [Number] {
    let above = numbers[symbol.line - 1]
    let this = numbers[symbol.line]
    let below = numbers[symbol.line + 1]
    let all = (this ?? []) + (above ?? []) + (below ?? [])

    var adjacency: [Number] = []
    for number in all {
        let numberLength = Int(trunc(log10(Double(number.number))))
        let range = (number.anchor-1)...(number.anchor + numberLength + 1)
        if range.contains(symbol.anchor) {
            adjacency.append(number)
        }
    }

    return adjacency
}

var sum = 0
for lineNumber in symbols.keys.sorted() {
    for symbol in symbols[lineNumber]! {
        if symbol.symbol == "*" {
            let adjacents = adjacentsTo(symbol)
            if adjacents.count == 2 {
                let ratio = adjacents[0].number * adjacents[1].number
                sum += ratio
            }
        }
    }
}

print(sum)

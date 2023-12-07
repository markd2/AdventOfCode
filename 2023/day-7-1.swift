#!/usr/bin/swift sh
import Foundation
import RegexBuilder

let inputFilename = "day-7-1-test.txt"
//let inputFilename = "day-7-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

// AKQJT98765432
enum Card: Int {
    case card2
    case card3
    case card4
    case card5
    case card6
    case card7
    case card8
    case card9
    case cardT
    case cardJ
    case cardQ
    case cardK
    case cardA

    init(_ char: Character) {
        switch(char) {
        case "2": self = Card.card2
        case "3": self = .card3
        case "4": self = .card4
        case "5": self = .card5
        case "6": self = .card6
        case "7": self = .card7
        case "8": self = .card8
        case "9": self = .card9
        case "T": self = .cardT
        case "J": self = .cardJ
        case "Q": self = .cardQ
        case "K": self = .cardK
        case "A": self = .cardA
        default:
            print("bad character: \(char)")
            self = .card2
        }
    }
}

struct Hand {
    let cards: [Card]
    let bid: Int
}
var hands: [Hand] = []

for line in lines {
    let line = line.split(separator: " ")
    var cards: [Card] = []
    for char in line[0] {
        cards.append(Card(char))
    }
    let bid = Int(line[1])!
    hands.append(Hand(cards: cards, bid: bid))
}

print(hands)

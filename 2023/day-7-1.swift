#!/usr/bin/swift sh
import Foundation
import RegexBuilder

//let inputFilename = "day-7-1-test.txt"
let inputFilename = "day-7-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

// AKQJT98765432
enum Card: Int, Comparable {
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

    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
 
struct Hand: Comparable {
    let cards: [Card]
    let bid: Int
    var type: HandType {
        determineType()
    }

    enum HandType: Int {
        case highCard
        case onePair
        case twoPair
        case threeOfAKind
        case fullHouse
        case fourOfAKind
        case fiveOfAKind
    }

    init(cards: [Card], bid: Int) {
        self.cards = cards
        self.bid = bid
    }

    func determineType() -> HandType {
        var countingCoup: [Card: Int] = [:]
        for card in cards {
            let val = countingCoup[card, default: 0]
            countingCoup[card] = val + 1
        }

        if countingCoup.keys.count == 1 { return .fiveOfAKind }
        if countingCoup.values.filter { $0 == 4 }.count == 1 { return .fourOfAKind }
        if countingCoup.keys.count == 2 { return .fullHouse }
        if countingCoup.values.filter { $0 == 3 }.count == 1 { return .threeOfAKind }
        if countingCoup.values.filter { $0 == 2 }.count == 2 { return .twoPair }
        if countingCoup.values.count == 5 { return .highCard }

        return .onePair
    }

    static func < (lhs: Hand, rhs: Hand) -> Bool {
        let thing1type = lhs.type
        let thing2type = rhs.type

        if thing1type == thing2type {
            for blah in zip(lhs.cards, rhs.cards) {
                if blah.0 == blah.1 { continue }
                return blah.0 < blah.1
            }
            print("shoud not have gotten here")
            return false
        } else {
            return thing1type.rawValue < thing2type.rawValue
        }
    }
    
    static func == (lhs: Hand, rhs: Hand) -> Bool {
        return lhs.cards == rhs.cards
    }
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

hands.sort()

var totalWinnings = 0

for (index, hand) in hands.enumerated() {
    totalWinnings += hand.bid * (index + 1)
}

print(totalWinnings)



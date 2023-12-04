#!/usr/bin/swift sh
import Foundation
import RegexBuilder

//let inputFilename = "day-4-1-test.txt"
let inputFilename = "day-4-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

class Card {
    let cardNumber: Int
    let winningNumbers: [Int]
    let pulledNumbers: [Int]
    var copies = 0

    init(cardNumber: Int, winningNumbers: [Int], pulledNumbers: [Int]) {
        self.cardNumber = cardNumber
        self.winningNumbers = winningNumbers
        self.pulledNumbers = pulledNumbers
    }

    var winners: Int {
        var winningSet = Set<Int>()
        var aWinnerIsMe = 0
        
        for pulled in pulledNumbers {
            if winningNumbers.contains(pulled) {
                aWinnerIsMe += 1
            }
        }
        return aWinnerIsMe
    }

    var score: Int {
        let winner = winners
        return winner == 0 ? 0 : 1 << (winner - 1)
    }
}

var cards: [Card] = []
for line in lines {
    let halvsies = line.split(separator: "|")

    // left half
    let lefties = String(halvsies[0]).split(separator: ":")
    let cardID = lefties[0].split(separator: " ")[1]
    let cardNumber = Int(String(cardID))!
    let winningNumbers = lefties[1].split(separator: " ").map { Int(String($0)) }.compactMap { $0 }

    // right half
    let pulls = halvsies[1].split(separator: " ")
    let pulledNumbers = pulls.map { Int(String($0)) }.compactMap { $0 }

    let card = Card(cardNumber: cardNumber, winningNumbers: winningNumbers,
                    pulledNumbers: pulledNumbers)
    cards.append(card)
}

for card in cards {
    sum += card.score
}

for card in cards {
    let winCount = card.winners
    guard winCount > 0 else { continue }

    for x in 0 ..< card.copies + 1 {

        for i in 0 ..< winCount {
            cards[card.cardNumber + i].copies += 1
        }
    }
}

var sum = 0
for card in cards {
    sum += card.copies + 1
}

print(sum)

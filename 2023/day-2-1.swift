#!/usr/bin/swift sh
import Foundation


//let inputFilename = "day-2-1-test.txt"
let inputFilename = "day-2-prod.txt"

// ----------
let input = try! String(contentsOfFile: inputFilename)
let lines = input.split(separator: "\n")
// ----------

// Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
// split on : to get gameIDs and draws
// split on ; to get games
// split on , to get individal pairs
// split on space to get pieces

struct Game {
    let gameNumber: Int

    struct Draw {
        let red: Int
        let green: Int
        let blue: Int

        func allLessThanOrEqual(_ thing2: Draw) -> Bool {
            return red <= thing2.red && green <= thing2.green && blue <= thing2.blue
        }
    }
    let draws: [Draw]
}

func twosplit(_ string: String, separator: String) -> (String, String) {
    let blah = string.split(separator: separator)
    assert(blah.count == 2)

    return(String(blah[0]), String(blah[1]))
}

// Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green

func splitIntoGame(_ line: String) -> Game {
    let (rawGame, rawDraws) = twosplit(line, separator: ":")
    let (_,  gameID) = twosplit(rawGame, separator: " ")

    var finalDraws: [Game.Draw] = []

    let turns = rawDraws.split(separator: ";")
    for turn in turns {
        let draws = turn.split(separator: ",")

        var red = 0
        var green = 0
        var blue = 0

        for draw in draws {
            let (count, color) = twosplit(String(draw), separator: " ")
            switch color {
            case "red": red = Int(count)!
            case "green": green = Int(count)!
            case "blue": blue = Int(count)!
            default: print("houston we have a probleem: \(line)")
            }
        }
        finalDraws.append(Game.Draw(red: red, green: green, blue: blue))
    }

    let game = Game(gameNumber: Int(gameID)!, draws: finalDraws)
    return game
}

var games: [Game] = []
for line in lines {
    let game = splitIntoGame(String(line))
    games.append(game)
}

let baseline = Game.Draw(red: 12, green: 13, blue: 14)

var sum = 0

nextGame:
for game in games {
    for draw in game.draws {
        if !draw.allLessThanOrEqual(baseline) {
            print("killing game \(game.gameNumber) for draw \(draw)")
            continue nextGame
        }
    }
    sum += game.gameNumber
}

print(sum)

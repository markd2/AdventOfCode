#import <iostream>
#import <string>
#import <sstream>

// clang++ -std=c++20 -o day-2-1 day-2-1.cpp 
// ./day-2-1 < day-2-1-example.txt
// ./day-2-1 < day-2-1-prod.txt

enum class RPS { // `enum class RPS: char`  would be cromulent
    Rock,
    Paper,
    Scissors
};

enum class Outcome {
    Win,
    Lose,
    Draw
};

RPS toRPS(std::string input) {
    if (input == "A" || input == "X") {
        return RPS::Rock;
    }

    if (input == "B" || input == "Y") {
        return RPS::Paper;
    }

    if (input == "C" || input == "Z") {
        return RPS::Scissors;
    }

    std::cout << "oops - bad RPS token |" << input << "|" << std::endl;
    exit(-1);
}

Outcome round(RPS player, RPS opponent) {
    Outcome result;

    switch (player) {
    case RPS::Rock:
        switch (opponent) {
        case RPS::Rock:
            result = Outcome::Draw;
            break;
        case RPS::Paper:
            result = Outcome::Lose;
            break;
        case RPS::Scissors:
            result = Outcome::Win;
            break;
        }
        break;
    case RPS::Paper:
        switch (opponent) {
        case RPS::Rock:
            result = Outcome::Win;
            break;
        case RPS::Paper:
            result = Outcome::Draw;
            break;
        case RPS::Scissors:
            result = Outcome::Lose;
            break;
        }
        break;
    case RPS::Scissors:
        switch (opponent) {
        case RPS::Rock:
            result = Outcome::Lose;
            break;
        case RPS::Paper:
            result = Outcome::Win;
            break;
        case RPS::Scissors:
            result = Outcome::Draw;
            break;
        }
        break;
    }
    return result;
}

int roundScore(Outcome outcome) {
    switch (outcome) {
    case Outcome::Win: return 6;
    case Outcome::Lose: return 0;
    case Outcome::Draw: return 3;
    }
}

int playScore(RPS play) {
    switch (play) {
    case RPS::Rock: return 1;
    case RPS::Paper: return 2;
    case RPS::Scissors: return 3;
    }
}

// RPS::Rock, RPS::Paper, etc


int main() {
    std::string line;
    int sum = 0;
    while (std::getline(std::cin, line)) {
        std::stringstream ss(line);
        std::string rawOpponent, rawPlayer;
        ss >> rawOpponent;
        ss >> rawPlayer;

        auto opponent = toRPS(rawOpponent);
        auto player = toRPS(rawPlayer);
        auto outcome = round(player, opponent);

        auto pScore = playScore(player);
        auto rScore = roundScore(outcome);
        std::cout << line << " " << pScore << " " << rScore << std::endl;

        sum += pScore + rScore;
    }
    std::cout << sum << std::endl;
}


#import <iostream>
#import <string>
#import <sstream>

// clang++ -std=c++20 -o day-2-2 day-2-2.cpp 
// ./day-2-2 < day-2-1-example.txt
// ./day-2-2 < day-2-1-prod.txt

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
    if (input == "A") {
        return RPS::Rock;
    }

    if (input == "B") {
        return RPS::Paper;
    }

    if (input == "C") {
        return RPS::Scissors;
    }

    std::cout << "oops - bad RPS token |" << input << "|" << std::endl;
    exit(-1);
}

Outcome toOutcome(std::string input) {
    if (input == "X") {
        return Outcome::Lose;
    }

    if (input == "Y") {
        return Outcome::Draw;
    }

    if (input == "Z") {
        return Outcome::Win;
    }

    std::cout << "oops - bad outcome token |" << input << "|" << std::endl;
    exit(-1);
}

RPS toBeat(RPS play) {
    switch (play) {
    case RPS::Rock:
        return RPS::Paper;
    case RPS::Paper:
        return RPS::Scissors;
    case RPS::Scissors:
        return RPS::Rock;
    }
}

RPS toLoseTo(RPS play) {
    switch (play) {
    case RPS::Rock:
        return RPS::Scissors;
    case RPS::Paper:
        return RPS::Rock;
    case RPS::Scissors:
        return RPS::Paper;
    }
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
        std::string rawOpponent, rawOutcome;
        ss >> rawOpponent;
        ss >> rawOutcome;

        auto opponent = toRPS(rawOpponent);
        auto outcome = toOutcome(rawOutcome);

        auto rScore = roundScore(outcome);

        RPS play;

        switch (outcome) {
        case Outcome::Win:
            play = toBeat(opponent);
            break;
        case Outcome::Lose:
            play = toLoseTo(opponent);
            break;
        case Outcome::Draw:
            play = opponent;
            break;
        }

        auto pScore = playScore(play);
        std::cout << line << " " << pScore << " " << rScore << std::endl;

        sum += pScore + rScore;
    }
    std::cout << sum << std::endl;
}


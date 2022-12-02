#import <iostream>

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

Outcome round(RPS player1, RPS player2) {
    return Outcome::Win;
}

// RPS::Rock, RPS::Paper, etc


int main() {
    std::string line;
    while (std::getline(std::cin, line)) {
        std::cout << line << std::endl;
    }    
}


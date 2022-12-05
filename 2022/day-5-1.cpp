#import <iostream>

// Supply Stacks
// https://adventofcode.com/2022/day/5

// clang++ -std=c++20 -o day-5-1 day-5-1.cpp 
// ./day-5-1 < day-5-example.txt
// ./day-5-1 < day-5-prod.txt


int main() {
    using namespace std;

    std::string line;
    // parse stacks
    while (std::getline(std::cin, line)) {
        if (line[0] == ' ' && line[1] == '1') break;  // should be " 1   2   3 ..." line
        cout << line << endl;
    }

    // nom blank line
    std::getline(std::cin, line);

    // parse instructions
    std::getline(std::cin, line);
    cout << line << endl;
}


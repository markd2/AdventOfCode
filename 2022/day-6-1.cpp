#import <iostream>
#import <set>
#import <string>
#import <algorithm>

// Tuning Trouble
// https://adventofcode.com/2022/day/6

// clang++ -g -std=c++20 -o day-6-1 day-6-1.cpp 
// ./day-6-1 < day-6-example-1.txt
// ./day-6-1 < day-6-example-2.txt
// ./day-6-1 < day-6-example-3.txt
// ./day-6-1 < day-6-example-4.txt
// ./day-6-1 < day-6-example-5.txt
// ./day-6-1 < day-6-prod.txt

int main() {
    std::string line;

    std::cin >> line;
    int index = 0;
    do {
        const int windowSize = 4;
        auto window = line.substr(index, windowSize);
        std::set<char> checker(window.begin(), window.end());

//         std::cout << index << ": " << window << ": " << checker.size() << std::endl;

        if (checker.size() == windowSize) {
            std::cout << index + 4 << std::endl;
            break;
        }

        ++index;
    } while(true);

}

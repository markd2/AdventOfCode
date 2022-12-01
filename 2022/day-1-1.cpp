// Day 1-1

#import <iostream>

// clang++ -g -std=c++20 -o day-1-1 day-1-1.cpp
// ./day-1-1 < day-1-1-example.txt
// ./day-1-1 < day-1-1-prod.txt

int main() {
    using namespace std;

    string line;
    int max = 0;
    auto newMax = 0;
    while (getline(cin, line)) {

        if (line.empty()) {
            newMax = 0;
        } else {
            auto calories = stoi(line);
            newMax += calories;

            if (newMax > max) {
                max = newMax;
            }
        }
    }

    cout << max << endl;

    return 0;
} // main

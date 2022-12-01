// Day 1-2

#import <iostream>
#import <vector>

// clang++ -g -std=c++20 -o day-1-2 day-1-1.cpp
// ./day-1-2 < day-1-1-example.txt
// ./day-1-2 < day-1-1-prod.txt

int main() {
    using namespace std;

    vector<int> allTheThings;

    string line;
    auto newMax = 0;
    while (getline(cin, line)) {

        if (line.empty()) {
            allTheThings.push_back(newMax);
            newMax = 0;
        } else {
            auto calories = stoi(line);
            newMax += calories;
        }
    }
    // off by one!
    allTheThings.push_back(newMax);

    sort(allTheThings.begin(), allTheThings.end(), greater<int>());

    auto last3 = allTheThings[0] + allTheThings[1] + allTheThings[2];
    cout << last3 << endl;

    return 0;
} // main

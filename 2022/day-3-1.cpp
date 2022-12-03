#import <algorithm>
#import <iostream>
#import <set>
#import <string>

// Rucksack reorganization
// https://adventofcode.com/2022/day/3

// clang++ -std=c++20 -o day-3-1 day-3-1.cpp 
// ./day-3-1 < day-3-example.txt
// ./day-3-1 < day-3-prod.txt

using namespace std;
int score(char blarg) {
    int score;

    // Assumes ASCII, because we can %-)
    if (blarg >= 'a') {
        score = blarg - 'a' + 1;
    } else {
        score = blarg - 'A' + 1 + 26;
    }
    return score;
}

int main() {
    string line;
    int sum = 0;
    while (getline(cin, line)) {
        set<char> ruck1, ruck2;
        auto half = line.length() / 2;
        for (int i = 0; i < half; i++) {
            ruck1.insert(line[i]);
        }
        for (int i = half; i < line.length(); i++) {
            ruck2.insert(line[i]);
        }
        set<char> intersect;
        set_intersection(ruck1.begin(), ruck1.end(),
                         ruck2.begin(), ruck2.end(),
                         inserter(intersect, intersect.begin()));

        char blah = *intersect.begin();
        int s = score(blah);
        sum += s;
        cout << blah << " " << s << endl;
    }
    cout << sum << endl;
}

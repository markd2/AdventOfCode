#import <algorithm>
#import <iostream>
#import <set>
#import <string>

// Rucksack reorganization
// https://adventofcode.com/2022/day/3

// clang++ -std=c++20 -o day-3-2 day-3-2.cpp 
// ./day-3-2 < day-3-example.txt
// ./day-3-2 < day-3-prod.txt

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

set<char> fromString(const string &s) {
    set<char> thing;
    for (int i = 0; i < s.length(); i++) {
        thing.insert(s[i]);
    }
    return thing;
}

set<char> intersect(const set<char> &thing1, const set<char> &thing2) {
    set<char> intersect;
    set_intersection(thing1.begin(), thing1.end(),
                     thing2.begin(), thing2.end(),
                     inserter(intersect, intersect.begin()));
    return intersect;
}

int main() {
    string line1, line2, line3;
    int sum = 0;

    do {
        // grab three lines
        getline(cin, line1);
        getline(cin, line2);
        if (!getline(cin, line3)) break;

        set<char> elf1 = fromString(line1);
        set<char> elf2 = fromString(line2);
        set<char> elf3 = fromString(line3);
        set<char> diff1_2 = intersect(elf1, elf2);
        set<char> allTheThings = intersect(diff1_2, elf3);

        auto uniqueThing = *allTheThings.begin();
        sum += score(uniqueThing);
    } while(true);

    cout << sum << endl;
}

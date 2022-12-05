#import <iostream>
#import <stack>
#import <string>
#import <sstream>
#import <vector>
#import <algorithm>

// Supply Stacks
// https://adventofcode.com/2022/day/5

// clang++ -g -std=c++20 -o day-5-2 day-5-2.cpp 
// ./day-5-2 < day-5-example.txt
// ./day-5-2 < day-5-prod.txt


int main() {
    using namespace std;

    std::string line;
    // parse stacks

    stack<string> lines;

    // slurp in all the ascii art, then process from bottom to top
    while (std::getline(std::cin, line)) {
        if (line[0] == ' ' && line[1] == '1') break;  // should be " 1   2   3 ..." line
        lines.push(line);
    }

    // How many columns we talking aboot?
    // top of stack (bottom line in sample) is max length
    
    auto numStacks = (lines.top().size() / 4) + 1;
    vector<string> stacks[numStacks];

    // process ASCII art bottom to top
    while (!lines.empty()) {
        string line = lines.top();

        for (int i = 0; i < numStacks; i++) {
            auto substring = line.substr(i * 4, 4);
            auto guts = substring.substr(1, 1);
            if (guts == " ") continue;
            stacks[i].push_back(guts);
        }

        lines.pop();
    }

    // nom blank line
    std::getline(std::cin, line);

    // parse instructions
    while (getline(cin, line)) {
        std::stringstream ss(line);
        std::string move, count, from, source, to,destination;

        ss >> move;
        ss >> count;
        ss >> from;
        ss >> source;
        ss >> to;
        ss >> destination;

        if (line.size() == 0) break;

        int icount = stoi(count);
        int ifrom = stoi(source) - 1;
        int ito = stoi(destination) - 1;

        // cout << icount << " " << ifrom << " " << ito << endl;

        auto fromm = stacks[ifrom];
        auto too = stacks[ito];

        too.insert(too.end(), 
                   make_move_iterator(fromm.begin() + (fromm.size() - icount)),
                   make_move_iterator(fromm.end()));
        fromm.resize(fromm.size() - icount);

        stacks[ifrom] = fromm;
        stacks[ito] = too;
    }

    for (int i = 0; i < numStacks; i++) {
        cout << stacks[i].back();
    }

    cout << endl;
}


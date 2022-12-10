#import <iostream>
#import <vector>

// https://adventofcode.com/2022/day/10
// Cathode Ray Tuba

// clang++ -g -std=c++20 -o day-10-1 day-10-1.cpp 
// ./day-10-1 < day-10-example.txt
// ./day-10-1 < day-10-prod.txt

using namespace std;

vector<string> instructions;

int main() {
    string line;

    // Slurp instructions
    while(getline(cin, line)) {
        cout << line << endl;
        if (line[0] == 'a') {
            instructions.push_back("noop");
        }
        instructions.push_back(line);
    }

    // start executing
    int cycle = 1;
    int X = 1;
    int strengthSum = 0;
    for (auto instruction: instructions) {
        if (instruction[0] == 'a') {
            auto numberString = instruction.substr(5, instruction.size() - 5);
            auto number = stoi(numberString);
            X += number;
        }

        cycle++;
        if (cycle == 20 || ((cycle - 20) % 40 == 0) ) {
            cout << "cycle " << cycle << " X " << X << " strength " << X * cycle << endl;
            strengthSum += X * cycle;
        }
    }
    cout << strengthSum << endl;
}

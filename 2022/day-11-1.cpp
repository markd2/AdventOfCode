#import <iostream>
#import <vector>
#import <sstream>

// https://adventofcode.com/2022/day/11
// Shiny Monkey Dog In The Middle

// clang++ -g -std=c++20 -o day-11-1 day-11-1.cpp 
// ./day-11-1 < day-11-example.txt
// ./day-11-1 < day-11-prod.txt

using namespace std;


struct Monkey {
    vector<int> items;
    string op; // + * - /
    string rhs;  // right hand side.  e.g. "3" or "old"
    int divisibility;
    int throwTrue;
    int throwFalse;
    
};

vector<Monkey> monkies;

int main() {
    string line;

    Monkey monkey;
    monkies.push_back(monkey);

    while(getline(cin, line)) {
        // Monkey 0:
        if (line.rfind("Monkey", 0) == 0) { continue; }

        //   Starting items: 79, 98
        if (int index = line.rfind("  Starting items: ") == 0) {
            auto items = line.substr(18, line.size() - 18);

            stringstream ss(items);
            vector<int> splunge;
            string token;
            while (getline(ss, token, ',')) {
                ss.ignore();
                splunge.push_back(stoi(token));
            }
            monkey.items = splunge;
            continue;
        }

        //   Operation: new = old + 3
        string opMatch = "  Operation: new = old ";
        if (int index = line.rfind(opMatch) == 0) {
            auto opration = line.substr(opMatch.size(), line.size() - opMatch.size());
            std::stringstream ss(opration);
            string op, rhs;
            ss >> op;
            ss >> rhs;
            monkey.op = op;
            monkey.rhs = rhs;
            continue;
        }

        if (line.size() == 0) {
            monkey = Monkey();
            monkies.push_back(monkey);
        }
    }

    cout << monkies.size() << endl;
}

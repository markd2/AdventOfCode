#import <deque>
#import <iostream>
#import <sstream>
#import <vector>

// https://adventofcode.com/2022/day/11
// Shiny Monkey Dog In The Middle

// clang++ -g -std=c++20 -o day-11-1 day-11-1.cpp 
// ./day-11-1 < day-11-example.txt
// ./day-11-1 < day-11-prod.txt

using namespace std;


struct Monkey {
    deque<int> items;
    string op; // + * - /
    string rhs;  // right hand side.  e.g. "3" or "old"
    int divisibility;
    int throwTrue;
    int throwFalse;
    int monkeyNumber = 0;

    int inspectedCount = 0;
    
    int computedWorry(int startingWorryLevel);
};


int Monkey::computedWorry(int startingWorryLevel) {
    int rvalue = (rhs == "old") ? startingWorryLevel : stoi(rhs);
    int lvalue = -1;
    switch (op[0]) {
    case '+':
        lvalue = startingWorryLevel + rvalue;
        break;
    case '-':
        lvalue = startingWorryLevel - rvalue;
        break;
    case '*':
        lvalue = startingWorryLevel * rvalue;
        break;
    case '/':
        lvalue = startingWorryLevel / rvalue;
        break;
    default:
        cout << "OH NOES " << op << endl;
    }
    return lvalue;
}


vector<Monkey> monkies;

int main() {
    string line;

    Monkey monkey;

    while(getline(cin, line)) {
        // Monkey 0:
        if (line.rfind("Monkey", 0) == 0) { continue; }

        //   Starting items: 79, 98
        if (int index = line.rfind("  Starting items: ") == 0) {
            auto items = line.substr(18, line.size() - 18);

            stringstream ss(items);
            deque<int> splunge;
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

        string divMatch = "  Test: divisible by ";
        if (int index = line.rfind(divMatch) == 0) {
            auto divvy = line.substr(divMatch.size(), line.size() - divMatch.size());
            monkey.divisibility = stoi(divvy);
        }
        
        string trueMatch = "    If true: throw to monkey";
        if (int index = line.rfind(trueMatch) == 0) {
            auto rest = line.substr(trueMatch.size(), line.size() - trueMatch.size());
            monkey.throwTrue = stoi(rest);
        }

        string falseMatch = "    If false: throw to monkey";
        if (int index = line.rfind(falseMatch) == 0) {
            auto rest = line.substr(falseMatch.size(), line.size() - falseMatch.size());
            monkey.throwFalse = stoi(rest);
        }

        if (line.size() == 0) {
            monkies.push_back(monkey);
            monkey = Monkey();
        }
    }
    
    for (int i = 0; i < monkies.size(); i++) {
        monkies[i].monkeyNumber = i;
    }

    monkies.push_back(monkey);

    int turn = 0;
    const int maxTurn = 20;
    while (true) {
        if (turn >= maxTurn) {
            break;
        }
        cout << "turn " << turn << endl;
        for (auto &monkey: monkies) {
            cout << "  monkey: " << monkey.monkeyNumber << endl;
            for (auto item: monkey.items) {
                monkey.inspectedCount++;
                int worryLevel = item;
                worryLevel = monkey.computedWorry(worryLevel);
                worryLevel /= 3;
                
                int throwIndex = -1;
                if (worryLevel % monkey.divisibility == 0) {
                    throwIndex = monkey.throwTrue;
                } else {
                    throwIndex = monkey.throwFalse;
                }
                cout << "    tossing " << item << "  to " << throwIndex << " worry " << worryLevel << endl;

                // throw to another monkey
                monkey.items.pop_front();
                monkies[throwIndex].items.push_back(worryLevel);
            }
        }
        turn++;
    }
    for (auto monkey: monkies) {
        cout << "look at " << monkey.inspectedCount << endl;
    }
}

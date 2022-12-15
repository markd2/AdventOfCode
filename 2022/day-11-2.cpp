#import <deque>
#import <iostream>
#import <sstream>
#import <vector>

#import "num.hpp"

// https://adventofcode.com/2022/day/11
// Shiny Monkey Dog In The Middle

// clang++ -g -std=c++20 -o day-11-2 day-11-2.cpp 
// ./day-11-2 < day-11-example.txt
// ./day-11-2 < day-11-prod.txt

using namespace std;


struct Monkey {
    deque<Num> items;
    string op; // + * - /
    string rhs;  // right hand side.  e.g. "3" or "old"
    int divisibility;
    int throwTrue;
    int throwFalse;
    int monkeyNumber = 0;

    int inspectedCount = 0;
    
    Num computedWorry(Num startingWorryLevel);
};


Num Monkey::computedWorry(Num startingWorryLevel) {
    Num rvalue = (rhs == "old") ? startingWorryLevel : stoi(rhs);
    Num lvalue = -1;
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
            deque<Num> splunge;
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
    const int maxTurn = 10'000;
    while (true) {
        if (turn >= maxTurn) {
            break;
        }
//        cout << "turn " << turn << endl;
        for (auto &monkey: monkies) {
//            cout << "  monkey: " << monkey.monkeyNumber << endl;
            for (auto item: monkey.items) {
                monkey.inspectedCount++;
                Num worryLevel = item;
                worryLevel = monkey.computedWorry(worryLevel);
//                worryLevel /= 3;
                
                int throwIndex = -1;
                if (worryLevel % monkey.divisibility == 0) {
                    throwIndex = monkey.throwTrue;
                } else {
                    throwIndex = monkey.throwFalse;
                }
//                cout << "    tossing " << item << "  to " << throwIndex << " worry " << worryLevel << endl;

                // throw to another monkey
                monkey.items.pop_front();
                monkies[throwIndex].items.push_back(worryLevel);
            }
        }
        if (turn % 10 == 0) {
            cout << "turn " << turn << endl;
            cout << monkies[0].items[0];
        }

        turn++;
        if (turn == 1 || turn == 20 || turn == 1000 || turn == 2000 || turn == 3000 || turn == 4000 || turn == 5000 || turn == 6000 || turn == 7000 || turn == 8000 || turn == 9000 || turn == 10000) {
            cout << "turn " << turn << endl;
            for (auto monkey: monkies) {
                cout << "  monkey " << monkey.monkeyNumber << " inspected " << monkey.inspectedCount << endl;
            }
        }
    }

    sort(monkies.begin(), monkies.end(),
         [](const Monkey &thing1, const Monkey &thing2) -> bool {
             return thing1.inspectedCount > thing2.inspectedCount;
         });
    for (auto monkey: monkies) {
        cout << "look at " << monkey.inspectedCount << endl;
    }
    int solution = monkies[0].inspectedCount * monkies[1].inspectedCount;
    cout << solution << endl;
}

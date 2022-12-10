#import <iostream>
#import <vector>

// https://adventofcode.com/2022/day/8

// clang++ -g -std=c++20 -o day-8-1 day-8-1.cpp 
// ./day-8-1 < day-8-example.txt
// ./day-8-1 < day-8-prod.txt

using namespace std;

struct Tree {
    int height;
    bool visibleFromTop = false;
    bool visibleFromBottom = false;
    bool visibleFromLeft = false;
    bool visibleFromRight = false;

    bool anyVisible();
};

bool Tree::anyVisible() {
    return visibleFromTop || visibleFromBottom || visibleFromLeft || visibleFromRight;
}

std::vector<std::vector<Tree>> forest;


void visibleMap() {
    for (auto stripe: forest) {
        for (auto tree: stripe) {
            cout << (tree.anyVisible() ? "#" : ".");
        }
        cout << endl;
    }
}

int main() {
    string line;
    
    while(getline(cin, line)) {
        vector<Tree> stripe;

        for (auto ch: line) {
            Tree tree;
            tree.height = ch - '0';
            stripe.push_back(tree);
        }
        forest.push_back(stripe);
        cout << line << endl;
    }

    forest[1][2].visibleFromTop = true;

    visibleMap();
}

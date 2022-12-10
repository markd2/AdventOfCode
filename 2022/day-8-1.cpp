#import <iostream>
#import <vector>

// https://adventofcode.com/2022/day/8

// clang++ -g -std=c++20 -o day-8-1 day-8-1.cpp 
// ./day-8-1 < day-8-example.txt
// ./day-8-1 < day-8-prod.txt

using namespace std;

enum class Direction {
    FromTop,
    FromLeft,
    FromBottom,
    FromRight
};

struct Tree {
    int height;
    bool visibleFromTop = false;
    bool visibleFromBottom = false;
    bool visibleFromLeft = false;
    bool visibleFromRight = false;

    bool anyVisible();
};

const int kAlwaysVisible = -1;

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

int tallestFrom(int treeRow, int treeColumn, Direction direction) {
    int tallest = -1;

    if (direction == Direction::FromLeft) {
        if (treeColumn == 0) return kAlwaysVisible;
        for (int column = 0; column < treeColumn; column++) {
            tallest = max(tallest, forest[treeRow][column].height);
        }
    }
    if (direction == Direction::FromRight) {
        int maxWidth = forest[treeRow].size();
        if (treeColumn == maxWidth - 1) return kAlwaysVisible;
        for (int column = treeColumn + 1; column < maxWidth; column++) {
            tallest = max(tallest, forest[treeRow][column].height);
        }
    }
    if (direction == Direction::FromTop) {
        if (treeRow == 0) return kAlwaysVisible;
        for (int row = 0; row < treeRow; row++) {
            tallest = max(tallest, forest[row][treeColumn].height);
        }
    }
    if (direction == Direction::FromBottom) {
        int maxHeight = forest.size();
        if (treeRow == maxHeight - 1) return kAlwaysVisible;
        for (int row = treeRow + 1; row < maxHeight; row++) {
            tallest = max(tallest, forest[row][treeColumn].height);
        }
    }

    return tallest;
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
    
    int width = forest[0].size();
    int height = forest.size();

    cout << "width " << width << " height " << height << endl;

    for (int row = 0; row < height; row++) {
        for (int column = 0; column < width; column++) {
            auto tallestLeft = tallestFrom(row, column, Direction::FromLeft);
            if (tallestLeft < forest[row][column].height) {
                forest[row][column].visibleFromLeft = true;                
            }

            auto tallestRight = tallestFrom(row, column, Direction::FromRight);
            if (tallestRight < forest[row][column].height) {
                forest[row][column].visibleFromRight = true;                
            }

            auto tallestTop = tallestFrom(row, column, Direction::FromTop);
            if (tallestTop < forest[row][column].height) {
                forest[row][column].visibleFromTop = true;                
            }

            auto tallestBottom = tallestFrom(row, column, Direction::FromBottom);
            if (tallestBottom < forest[row][column].height) {
                forest[row][column].visibleFromBottom = true;                
            }
        }
    }

    // forest[1][2].visibleFromTop = true;

    visibleMap();
}

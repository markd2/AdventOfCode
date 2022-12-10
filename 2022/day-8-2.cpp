#import <iostream>
#import <vector>

// https://adventofcode.com/2022/day/8

// clang++ -g -std=c++20 -o day-8-2 day-8-2.cpp 
// ./day-8-2 < day-8-example.txt
// ./day-8-2 < day-8-prod.txt

using namespace std;

enum class Direction {
    LookingUp,
    LookingLeft,
    LookingDown,
    LookingRight
};

struct Tree {
    int height = 0;
    int scenicScore = 0;
};

const int kAlwaysVisible = -1;

std::vector<std::vector<Tree>> forest;


int scenicScore(int treeRow, int treeColumn, Direction direction) {
    int score = 0;
    int height = forest[treeRow][treeColumn].height;

    if (direction == Direction::LookingLeft) {
        if (treeColumn == 0) return 0;
        for (int column = treeColumn - 1; column >= 0; column--) {
            if (forest[treeRow][column].height <= height) {
                score += 1;
            }
            if (forest[treeRow][column].height >= height) {
                break;
            }
        }
    }
    if (direction == Direction::LookingRight) {
        int max = forest[treeRow].size();
        if (treeColumn == max - 1) return 0;
        for (int column = treeColumn + 1; column < max; column++) {
            if (forest[treeRow][column].height <= height) {
                score += 1;
            }
            if (forest[treeRow][column].height >= height) {
                break;
            }
        }
    }
    if (direction == Direction::LookingUp) {
        if (treeRow == 0) return 0;
        for (int row = treeRow - 1; row >= 0; row--) {
            if (forest[row][treeColumn].height <= height) {
                score += 1;
            }
            if (forest[row][treeColumn].height >= height) {
                break;
            }
        }
    }
    if (direction == Direction::LookingDown) {
        int max = forest.size();
        if (treeRow == max - 1) return 0;
        for (int row = treeRow + 1; row < max; row++) {
            if (forest[row][treeColumn].height <= height) {
                score += 1;
            }
            if (forest[row][treeColumn].height >= height) {
                break;
            }
        }
    }

    if (score == 0) return 1;
    return score;
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


    int maxScore = 0;
    for (int row = 0; row < height; row++) {
        for (int column = 0; column < width; column++) {
            auto scenicLeft = scenicScore(row, column, Direction::LookingLeft);
            auto scenicRight = scenicScore(row, column, Direction::LookingRight);
            auto scenicUp = scenicScore(row, column, Direction::LookingUp);
            auto scenicDown = scenicScore(row, column, Direction::LookingDown);
            forest[row][column].scenicScore = scenicLeft * scenicRight * scenicUp * scenicDown;
            maxScore = max(maxScore, forest[row][column].scenicScore);
        }
    }

    {
        int row = 2; int column = 1;
        auto scenicLeft = scenicScore(row, column, Direction::LookingLeft);
        auto scenicRight = scenicScore(row, column, Direction::LookingRight);
        auto scenicUp = scenicScore(row, column, Direction::LookingUp);
        auto scenicDown = scenicScore(row, column, Direction::LookingDown);
        cout << scenicLeft << " " << scenicRight  << " " << scenicUp  << " " << scenicDown << endl;
    }

    for (int row = 0; row < height; row++) {
        for (int column = 0; column < width; column++) {
            cout << forest[row][column].scenicScore << " ";
        }
        cout << endl;
    }
    cout << maxScore << endl;

}

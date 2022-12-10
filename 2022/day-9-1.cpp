#import <iostream>
#import <vector>

// https://adventofcode.com/2022/day/9
// Rope Bridge

// clang++ -g -std=c++20 -o day-9-1 day-9-1.cpp 
// ./day-9-1 < day-9-example.txt
// ./day-9-1 < day-9-prod.txt

using namespace std;

enum class Direction {
    Up,
    Down,
    Left,
    Right
};

struct Point {
    int row = 0;
    int column = 0;

    Point(int r, int c) : row(r), column(c) { }
    void move(Direction);
};

void Point::move(Direction direction) {
    switch (direction) {
    case Direction::Up:
        row--;
        break;
    case Direction::Down:
        row++;
        break;
    case Direction::Left:
        column--;
        break;
    case Direction::Right:
        column++;
        break;
    }
}

Direction directionFor(const string &instruction) {
    switch (instruction[0]) {
    case 'U':
        return Direction::Up;
        break;
    case 'D':
        return Direction::Down;
        break;
    case 'L':
        return Direction::Left;
        break;
    case 'R':
        return Direction::Right;
        break;
    default:
        assert(!"SPLUNGE");
    }
}

vector<string> instructions;
vector<vector<bool>> board;

void printBoard() {
    int width = board[0].size();
    int height = board.size();

    for (int row = 0; row < height; row++) {
        for (int column = 0; column < width; column++) {
            cout << (board[row][column] ? "#" : ".");
        }
        cout << endl;
    }
}

int main() {
    string line;

    // Slurp instructions
    while(getline(cin, line)) {
        instructions.push_back(line);
    } 

    // figure out how big our playfield needs to be
    Point point(0, 0);
    int minRow = 0, maxRow = 0;
    int minCol = 0, maxCol = 0;
    for (auto line: instructions) {
        auto direction = directionFor(line);
        int count = stoi(line.substr(2, line.size() - 2));

        for (int i = 0; i < count; i++) {
            point.move(direction);
            minRow = min(minRow, point.row);
            maxRow = max(maxRow, point.row);
            minCol = min(minCol, point.column);
            maxCol = max(maxCol, point.column);
        }
    }

    // larger
    int width = maxRow - minRow + 1 + 3 + 20; // %-)
    int height = maxCol - minCol + 1 + 1 + 20;

    if (width > 10) {
        width = max(width, 301);
        height = max(width, 220); // hacks....
    }

    int startRow = abs(minRow) + 1;
    int startColumn = abs(minCol) + 1;

    cout << minRow << " " << maxRow << " " << height << " " << startRow << endl;
    cout << minCol << " " << maxCol << " " << width << " " << startColumn << endl;

    Point head(startRow, startColumn);
    Point tail(startRow, startColumn);

    for (int row = 0; row < height; row++) {
        vector<bool> stripe;
        for (int column = 0; column < width; column++) {
            stripe.push_back(false);
        }
        board.push_back(stripe);
    }

    // move the head around

    for (auto line: instructions) {
        auto direction = directionFor(line);
        int count = stoi(line.substr(2, line.size() - 2));

        for (int i = 0; i < count; i++) {
            head.move(direction);
            board[head.row][head.column] = true;
        }
    }

    // print out the track
    printBoard();
}

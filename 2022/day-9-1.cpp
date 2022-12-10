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
    void move(Point); // move the tail
    bool isTouching(Point); // 8 directions
    bool isOrthogonallyAway(Point); // 4 directions
};

bool Point::isTouching(Point point) {
    if (abs(point.row - row) >= 2) return false;
    if (abs(point.column - column) >= 2) return false;
    return true;
}

bool Point::isOrthogonallyAway(Point point) {
    if (point.row == row || point.column == column) return true;
    return false;
}

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

void Point::move(Point head) {
    if (isTouching(head)) {
        return;
    }

    if (isOrthogonallyAway(head)) {
        if (head.row == row) { // same row
            if (head.column - column > 0) { // to the right
                column++;
            } else {
                column--; // to the left
            }
        } else { // same column
            if (head.row - row > 0) { // below
                row++;
            } else {
                row--;  // above
            }
        }
        return;
    }

    // otherwise move diagonally
    {
        // via a diagram (hi Via!), if the Head is in the middle at the origin,
        // - tails in quadrant 1 travel SW  (Down Left)
        // - tails in quadrant 2 travel NW  (Up Left)
        // - tails in quadrant 3 travel NE  (Up Right)
        // - tails in quadrant 4 travel SE  (Down Right)
        //   *or*
        // - tails to the left of the head move East
        // - tails to the right of the head move West
        //
        // - tails above the head move south
        // - tails below the head move north
        Direction move1, move2;

        if (column > head.column) {
            move1 = Direction::Left;
        } else {
            move1 = Direction::Right;
        }

        if (row < head.row) {
            move2 = Direction::Down;
        } else {
            move2 = Direction::Up;
        }
        move(move1);
        move(move2);
        return;
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

int printBoardAndCountTailCells() {
    int sum = 0;
    int width = board[0].size();
    int height = board.size();

    for (int row = 0; row < height; row++) {
        for (int column = 0; column < width; column++) {
            cout << (board[row][column] ? "#" : ".");
            if (board[row][column]) sum++;
        }
        cout << endl;
    }
    return sum;
}

void printHeadTail(Point head, Point tail) {
    int width = board[0].size();
    int height = board.size();

    for (int row = 0; row < height; row++) {
        for (int column = 0; column < width; column++) {
            if (head.row == row && head.column == column) {
                if (tail.row == row && tail.column == column) {
                    cout << "X";
                } else {
                    cout << "H";
                }
            } else if (tail.row == row && tail.column == column) {
                if (head.row == row && head.column == column) {
                    cout << "X";
                } else {
                    cout << "T";
                }
            } else {
                cout << ".";
            }
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
    int width = maxRow - minRow + 1 + 1; // %-)
    int height = maxCol - minCol + 1 + 1;

    if (width > 10) {
        width += 50; // extra pad for paranoia
        height += 50;
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
    board[tail.row][tail.column] = true;

    // move the head around
    int moveCount = 6;

    printHeadTail(head, tail);
    cout << endl;

    for (auto line: instructions) {
        auto direction = directionFor(line);
        int count = stoi(line.substr(2, line.size() - 2));

        cout << "--------------------" << endl;
        cout << line << endl;

        for (int i = 0; i < count; i++) {
            cout << "    --------" << endl;
            moveCount--;
            head.move(direction);
            printHeadTail(head, tail);
            cout << " ==> " << endl;
            tail.move(head);
            board[tail.row][tail.column] = true;
            printHeadTail(head, tail);
            cout << "    --------" << endl << endl;
        }
        if (moveCount == 0) break;
    }

    // print out the track
    int sum = printBoardAndCountTailCells();
    cout << sum << endl;
}

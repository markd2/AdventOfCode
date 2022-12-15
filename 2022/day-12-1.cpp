#import <iostream>
#import <vector>

// clang++ -g -std=c++20 -o day-12-1 day-12-1.cpp 
// ./day-12-1 < day-12-example.txt
// ./day-12-1 < day-12-prod.txt

using namespace std;

enum Directions {
    North = 1 << 0,
    East = 1 << 1,
    South = 1 << 2,
    West = 1 << 3
};

struct Cell {
    int altitude;
    bool isStart;
    bool isTarget;
    int directionsSeen = 0;

    Cell(int altitude, bool isStart, bool isTarget) : altitude(altitude), isStart(isStart), isTarget(isTarget) { }
};

struct Point {
    int row = 0;
    int column = 0;

    Point() : row(0), column(0) { }
    Point(int row, int column) : row(row), column(column) { }
};

vector<vector<Cell>> terrain;
Point start;

void printBoard() {
    for (auto stripe: terrain) {
        for (auto cell: stripe) {
            if (cell.isStart) cout << "S";
            else if (cell.isTarget) cout << "E";
            else cout << cell.altitude + 'a';
        }
        cout << endl;
    }
}

int main() {
    string line;

    int row = 0, column = 0;
    while(getline(cin, line)) {
        column = 0;
        for (char alt: line) {
            Cell cell(alt - 'a', alt == 'S', alt == 'E');

            if (alt == 'S') {
                start = Point(row, column);
            }
            column++;
        }
        row++;
        cout << line << endl;
    }

    printBoard();
}

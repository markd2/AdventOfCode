#import <iostream>
#import <vector>

// clang++ -g -std=c++20 -o day-12-1 day-12-1.cpp 
// ./day-12-1 < day-12-example.txt
// ./day-12-1 < day-12-prod.txt

using namespace std;

enum Direction {
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

    const Point movedBy(Direction direction);
};

const Point Point::movedBy(Direction direction) {
    Point newPoint = *this;

    switch (direction) {
    case North:
        newPoint.row--;
        break;
    case East:
        newPoint.column++;
        break;
    case South:
        newPoint.row++;
        break;
    case West:
        newPoint.column--;
        break;
    }

    return newPoint;
}

vector<vector<Cell>> terrain;
Point start;

void printBoard() {
    for (auto stripe: terrain) {
        for (auto cell: stripe) {
            if (cell.isStart) cout << "S";
            else if (cell.isTarget) cout << "E";
            else {
                char blah = 'a' + cell.altitude;
                cout << blah;
            }
        }
        cout << "    ";
        for (auto cell: stripe) {
            if (cell.isStart) cout << "S";
            else if (cell.isTarget) cout << "E";
            else {
                char output;

                if (cell.directionsSeen & North) {
                    output = '^';
                } else if (cell.directionsSeen & East) {
                    output = '>';
                } else if (cell.directionsSeen & South) {
                    output = 'v';
                } else if (cell.directionsSeen &West) {
                    output = '<';
                } else {
                    output = '.';
                }  
                cout << output;
            }
        }
        cout << endl;
    }

    cout << "-------------------------" << endl;
}

Cell *cellAtPoint(Point point) {
    if (point.row < 0 || point.column < 0) return nullptr;
    if (point.row >= terrain.size() || point.column >= terrain[0].size()) return nullptr;

    return &terrain[point.row][point.column];
}

int walk(Point point, int count) {
    printBoard();
    Cell *cell = cellAtPoint(point);
    if (cell->isTarget) {
        return count;
    }

    Cell *neighbor;

    // try walking east
    Point east = point.movedBy(East);
    neighbor = cellAtPoint(east);
    if (neighbor != nullptr && !neighbor->directionsSeen) {
        cell->directionsSeen |= East;
        return walk(east, count + 1);
    }
    // try south
    Point south = point.movedBy(South);
    neighbor = cellAtPoint(south);
    if (neighbor != nullptr && !neighbor->directionsSeen) {
        cell->directionsSeen |= South;
        return walk(south, count + 1);
    }

    // try west
    Point west = point.movedBy(West);
    neighbor = cellAtPoint(west);
    if (neighbor != nullptr && !neighbor->directionsSeen) {
        cell->directionsSeen |= West;
        return walk(west, count + 1);
    }

    // try north
    Point north = point.movedBy(North);
    neighbor = cellAtPoint(north);
    if (neighbor != nullptr && !neighbor->directionsSeen) {
        cell->directionsSeen |= North;
        return walk(north, count + 1);
    }


    // zigzak until we find it.
    
    return 12;
}

int main() {
    string line;

    int row = 0, column = 0;
    while(getline(cin, line)) {
        column = 0;
        vector<Cell> stripe;
        for (char alt: line) {
            Cell cell(alt - 'a', alt == 'S', alt == 'E');
            stripe.push_back(cell);

            if (alt == 'S') {
                start = Point(row, column);
            }
            column++;
        }
        terrain.push_back(stripe);
        row++;
    }
    
    int distance = walk(start, 0);

    printBoard();
    cout << distance << endl;
}

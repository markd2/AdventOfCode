#import <iostream>
#import <vector>

// https://adventofcode.com/2022/day/10
// Cathode Ray Tuba

// clang++ -g -std=c++20 -o day-10-2 day-10-2.cpp 
// ./day-10-2 < day-10-example.txt
// ./day-10-2 < day-10-prod.txt

using namespace std;

vector<string> instructions;
vector<vector<string>> framebuffer;

const int width = 40;
const int height = 6;

struct Sprite {
    int Xposition = 0;

    void moveTo(int X) { Xposition = X; };
    bool pixelState(int pixelIndex) { return pixelIndex >= Xposition - 1 && pixelIndex <= Xposition + 1; }

};

void printscr() {
    for (auto stripe: framebuffer) {
        for (auto pixel: stripe) {
            cout << pixel;
        }
        cout << endl;
    }
}

int main() {
    string line;

    for (int i = 0; i < height; i++) {
        vector<string> stripe;
        for (int j = 0; j < width; j++) {
            stripe.push_back(".");
        }
        framebuffer.push_back(stripe);
    }

    // Slurp instructions
    while(getline(cin, line)) {
        cout << line << endl;
        if (line[0] == 'a') {
            instructions.push_back("noop");
        }
        instructions.push_back(line);
    }

    Sprite sprite;

    // start executing
    int cycle = 1;
    int X = 1;
    sprite.moveTo(X);
    int strengthSum = 0;
    for (auto instruction: instructions) {
        if (instruction[0] == 'a') {
            auto numberString = instruction.substr(5, instruction.size() - 5);
            auto number = stoi(numberString);
            X += number;
            sprite.moveTo(X);
        }

        int row = (cycle - 1) / 40;
        int column = (cycle -1) % 40;
        cout << row << " : " << column << endl;

        if ((row + column) % 3 == 0) {
            framebuffer[row][column] = "#";
        }

        cycle++;
        if (cycle >= 240) break;
/*
        if (cycle == 20 || ((cycle - 20) % 40 == 0) ) {
            cout << "cycle " << cycle << " X " << X << " strength " << X * cycle << endl;
            strengthSum += X * cycle;
        }
*/
    }
    printscr();
}

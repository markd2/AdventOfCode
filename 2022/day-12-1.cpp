#import <iostream>
#import <vector>

// clang++ -g -std=c++20 -o day-12-1 day-12-1.cpp 
// ./day-12-1 < day-12-example.txt
// ./day-12-1 < day-12-prod.txt

using namespace std;

int main() {
    string line;

    while(getline(cin, line)) {
        cout << line << endl;
    }
}

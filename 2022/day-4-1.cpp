#import <iostream>
#import <regex>

// Camp Cleaning
// https://adventofcode.com/2022/day/4

// clang++ -std=c++20 -o day-4-1 day-4-1.cpp 
// ./day-4-1 < day-4-example.txt
// ./day-4-1 < day-4-prod.txt


const auto matchElfRanges = "(\\d*)-(\\d*),(\\d*)-(\\d*)";

struct Range {
    int start;
    int end;

public:
    [[nodiscard]] const bool contains(const Range otherRange) noexcept {
        return otherRange.start >= start && otherRange.end <= end;
    }
};

int main() {
    std::string line;
    int sum = 0;
    std::regex matchRangesRegex(matchElfRanges);

    int count = 0;
    while (std::getline(std::cin, line)) {
        std::smatch matches;

        if (std::regex_search(line, matches, matchRangesRegex)) {

            auto elf1 = Range{ stoi(matches[1].str()),
                stoi(matches[2].str()) };
            auto elf2 = Range{ stoi(matches[3].str()), 
                stoi(matches[4].str()) };

            if (elf1.contains(elf2) || elf2.contains(elf1)) {
                count++;
            }
        } else {
            std::cout << "got unexpected unparsable input: |" << line << "|" << std::endl;
        }
    }
    std::cout << count << std::endl;
}

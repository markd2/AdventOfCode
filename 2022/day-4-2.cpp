#import <iostream>
#import <regex>

// Camp Cleaning
// https://adventofcode.com/2022/day/4

// clang++ -std=c++20 -o day-4-2 day-4-2.cpp 
// ./day-4-2 < day-4-example.txt
// ./day-4-2 < day-4-prod.txt


const auto matchElfRanges = "(\\d*)-(\\d*),(\\d*)-(\\d*)";

struct Range {
    int start;
    int end;

public:
    [[nodiscard]] constexpr const bool contains(const Range &otherRange) noexcept {
        return otherRange.start >= start && otherRange.end <= end;
    }

    [[nodiscard]] constexpr const bool overlaps(const Range &otherRange) noexcept {
        bool inStart = (otherRange.start >= start) && (otherRange.start <= end);
        bool inEnd = (otherRange.end >= start) && (otherRange.end <= end);

        return inStart || inEnd;
    }
};

// overlaps
// 1234567890     1234567890     1234567890     1234567890     1234567890    
//  |---|            |---|         |---|          |----|        |--|
//    |---|        |---|          |-----|         |----|           |--|

// doesn't
// 1234567890     1234567890
//  |--|               |--|    
//       |-|        |-|

void testOverlap() {
    // doesn't
    {
        Range r1 = Range{2, 5}, r2 = Range{7,9};
        assert(!r1.overlaps(r2));
        assert(!r2.overlaps(r1));
    }

    // does
    { // equality
        auto r1 = Range{2, 6};
        assert(r1.overlaps(r1));
    }
    { // overlap
        auto r1 = Range{2, 6}, r2 = Range{4,8};
        assert(r1.overlaps(r2));

        assert(r2.overlaps(r1));
    }
    { // precise overlap
        auto r1 = Range{2, 4}, r2 = Range{4,8};
        assert(r1.overlaps(r2));
        assert(r2.overlaps(r1));
    }
}

int main() {
    testOverlap();

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

            if (elf1.overlaps(elf2) || elf2.overlaps(elf1)) {
                count++;
            }
        } else {
            std::cout << "got unexpected unparsable input: |" << line << "|" << std::endl;
        }
    }
    std::cout << count << std::endl;
}

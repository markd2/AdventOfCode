#import <iostream>
#import <regex>

// Camp Cleaning
// https://adventofcode.com/2022/day/4

// clang++ -std=c++20 -o day-4-1 day-4-1.cpp 
// ./day-4-1 < day-4-example.txt
// ./day-4-1 < day-4-prod.txt


const auto matchElfRanges = "(\\d*)-(\\d*),(\\d*)-(\\d*)";

int main() {
    std::string line;
    int sum = 0;
    std::regex matchRangesRegex(matchElfRanges);

    while (std::getline(std::cin, line)) {
        std::cout << line << std::endl;
        std::smatch matches;

        if (std::regex_search(line, matches, matchRangesRegex)) {

            for (auto i = 0; i < matches.size(); ++i) {
                std::cout << i << ": " << matches[i].str() << std::endl;
            }
        } else {
            std::cout << "got unexpected unparsable input: |" << line << "|" << std::endl;
        }

        
#if 0
        auto ranges_begin = std::sregex_iterator(line.begin(), line.end(), matchRangesRegex);
        auto ranges_end = std::sregex_iterator();

        for (std::sregex_iterator i = ranges_begin; i != ranges_end; ++i) {
            std::smatch match = *i;
            std::string matchString = match.str();
            std::cout << matchString << std::endl;
        }
#endif
        break;
    }    
}

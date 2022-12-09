#import <iostream>
#import <map>
#import <vector>

// No Space Left On Device
// https://adventofcode.com/2022/day/7

// clang++ -g -std=c++20 -o day-7-1 day-7-1.cpp 
// ./day-7-1 < day-7-example.txt
// ./day-7-1 < day-7-prod.txt

struct inode {
    std::map<std::string, inode *> dirent;
};

inode *root = nullptr;
inode *cwd = nullptr;

void walk(const inode *root, int indent = 0) {
    std::vector<std::string> keys;
    for (std::map<std::string, inode*>::const_iterator it = root->dirent.begin();
         it !=  root->dirent.end(); ++it) {
        auto key = it->first;
        if (key == "..") continue;

        auto spaces = std::string(indent * 2, ' ');
        std::cout << spaces << key << std::endl;

        auto value = it->second;
        if (value != nullptr) {
            walk(value, indent + 1);
        }
    }
}

int main() {
    std::string line;
    while (std::getline(std::cin, line)) {
        if (line[0] == '$') {

            // --------------------
            // cd
            const std::string cd = "$ cd";
            if (line.compare(0, cd.size(), cd) == 0) {
                std::cout << line << std::endl;
                auto dirName = line.substr(5, line.size() - 5);

                if (root == nullptr) {
                    // we found /
                    std::cout << "made root";
                    root = new inode;
                    cwd = root;
                    continue;
                }
                // check if we've seen this directory yet.  If not,
                // add it.
                if (cwd->dirent[dirName] == nullptr) {
                    inode *newDirectory = new inode;
                    cwd->dirent[dirName] = newDirectory;
                    newDirectory->dirent[".."] = cwd;
                    std::cout << "added new directory |" << dirName << "|" << std::endl;
                }
                // then move to it
                cwd = cwd->dirent[dirName];
                continue;
            }
        }
    }

    walk(root);
    // std::cout << "blah" << std::endl;
}

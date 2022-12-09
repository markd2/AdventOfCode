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
    bool isDirectory = true;
    int size = -1;
};

inode *root = nullptr;
inode *cwd = nullptr;

int du(const inode *root) {
    int sum = 0;

    for (std::map<std::string, inode*>::const_iterator it = root->dirent.begin();
         it !=  root->dirent.end(); ++it) {
        if (it->first == "..") continue;

        auto inode = it->second;
        if (inode->isDirectory) {
            sum += du(inode);
        } else {
            sum += inode->size;
        }
    }

    return sum;
}

std::vector<const inode*> matchingInodes;

void walk(const inode *root, int indent = 0) {
    for (std::map<std::string, inode*>::const_iterator it = root->dirent.begin();
         it !=  root->dirent.end(); ++it) {
        auto key = it->first;
        auto value = it->second;

        if (key == "..") continue;

        auto spaces = std::string(indent * 2, ' ');
        std::cout << spaces << key << " " << (value->isDirectory ? "dir" : std::to_string(value->size)) << std::endl;
        if (value->isDirectory) {
            auto sum = du(value);
            if (sum <= 100'000) {
                matchingInodes.push_back(value);
            }
            std::cout << spaces << " sum: " << sum << std::endl;
        }

        if (value != nullptr) {
            walk(value, indent + 1);
        }
    }
}

int main() {
    std::string line;
    std::getline(std::cin, line);

    std::cout << "TOP OF LOOP " << line << std::endl;

    while (true) {
        const std::string cd = "$ cd";
        const std::string ls = "$ ls";

        std::cout << "TOP OF LOOP " << line << std::endl;

        if (line[0] == '$') {
            // --------------------
            std::cout << line << std::endl;
            if (line.compare(0, cd.size(), cd) == 0) {
                std::cout << line << std::endl;
                auto dirName = line.substr(5, line.size() - 5);

                if (root == nullptr) {
                    // we found /
                    std::cout << "made root" << std::endl;
                    root = new inode;
                    cwd = root;
                    if (!std::getline(std::cin, line)) break;
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
                if (!std::getline(std::cin, line)) break;
                continue;
            }

            if (line.compare(0, ls.size(), ls) == 0) {
                std::cout << "TOP OF LS" << line << std::endl;
                while(std::getline(std::cin, line)) {
                    // process line
                    std::cout << line << std::endl;
                    if (line[0] == 'd') {
                        auto dirName = line.substr(4, line.size() - 4);
                        if (cwd->dirent[dirName] == nullptr) {
                            std::cout << "    NEW NEW NEW" << std::endl;
                            inode *newDirectory = new inode;
                            cwd->dirent[dirName] = newDirectory;
                            newDirectory->dirent[".."] = cwd;
                            std::cout << "    added new directory |" << dirName << "|" << std::endl;
                        }

                        std::cout << "*" << dirName << std::endl;
                    } else {
                        // size, filename 
                        auto split = line.find(" ", 0);
                        auto filename = line.substr(split + 1, line.size() - (split + 1));
                        auto size = stoi(line.substr(0, split));
                        std::cout << "SNORGLE " << filename << "| " << size << std::endl;

                        inode *newFile = new inode;
                        newFile->isDirectory = false;
                        newFile->size = size;
                        cwd->dirent[filename] = newFile;
                    }

                    if (std::cin.peek() == '$') {
                        std::cout << "  YAY DONE" << std::endl;
                        break;
                    }
                    std::cout << line << std::endl;
                }
                // slurp up lines:
                //    - dir NAME
                //    - SIZE NAME
            }
        }
        if (!std::getline(std::cin, line)) break;
    }
    std::cout << "------------------------------" << std::endl;
    std::cout << "/ " << du(root) << std::endl;
    walk(root, 1);
    std::cout << "blah" << matchingInodes.size() << std::endl;

    // too lazy to figure out std::reduce for this
    int sum = 0;
    for (auto inode: matchingInodes) {
        sum += du(inode);
    }
    std::cout << sum << std::endl;
}

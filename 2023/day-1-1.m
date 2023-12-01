// clang -g -Wall -framework Foundation -o day-1-1 day-1-1.m

#import <Foundation/Foundation.h>
#import <ctype.h>

int main() {
    // NSString *inputFilename = @"day-1-1-test.txt";
    NSString *inputFilename = @"day-1-1-prod.txt";
    NSString *input = [[NSString alloc] initWithContentsOfFile: inputFilename
                                                      encoding: NSUTF8StringEncoding
                                                         error: NULL];
    NSArray<NSString *> *lines = [input componentsSeparatedByString: @"\n"];

    NSInteger sum = 0;
    for (NSString *line in lines) {
        if (line.length == 0) continue;

        // scan forward
        NSInteger first = 0, second = 0;

        char blargh[2] = { 0 };

        for (NSInteger i = 0; i < line.length; i++) {
            char candidate = [line characterAtIndex: i];
            if (isnumber(candidate)) {
                blargh[0] = candidate;
                first = atoi(blargh);
                break;
            }
        }

        for (NSInteger i = line.length - 1; i >= 0; i--) {
            char candidate = [line characterAtIndex: i];
            if (isnumber(candidate)) {
                blargh[0] = candidate;
                second = atoi(blargh);
                break;
            }
        }
        NSInteger value = first * 10 + second;
        sum += value;
    }

    NSLog(@"%ld", sum);

    return 0;

} // main

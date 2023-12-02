// clang -g -Wall -framework Foundation -o day-1-1 day-1-1.m
// clang -g -Wall -framework Foundation -o day-1-2 day-1-2.m

#import <Foundation/Foundation.h>
#import <ctype.h>

const NSInteger notfound = -1;

typedef struct Pear {
    NSInteger number;
    NSInteger index;
} Pear;

typedef enum {
    forward,
    backward
} Direction;


Pear numberByDigit(NSString *line, Direction direction) {
    Pear pear = { notfound, notfound };

    char blargh[2] = { 0 };
    if (direction == forward) {
        NSInteger found = 0;
        for (NSInteger i = 0; i < line.length; i++) {
            char candidate = [line characterAtIndex: i];
            if (isnumber(candidate)) {
                blargh[0] = candidate;
                found = atoi(blargh);
                pear.number = found;
                pear.index = i;
                break;
            }
        }
    } else {
        NSInteger found = 0;
        for (NSInteger i = line.length - 1; i >= 0; i--) {
            char candidate = [line characterAtIndex: i];
            if (isnumber(candidate)) {
                blargh[0] = candidate;
                found = atoi(blargh);
                pear.number = found;
                pear.index = i;
                break;
            }
        }
    }

    return pear;
} // numberByDigit

NSArray *values = @[
    @"one",
     @"two",
     @"three",
     @"four",
     @"five",
     @"six",
     @"seven",
     @"eight",
     @"nine",
];

void numberByString(NSString *line, Pear *outFirst, Pear *outSecond) {
    NSInteger pearIndex = 0;
    Pear pears[20] = { { notfound, notfound } };

    for (NSInteger i = 0; i < values.count; i++) {
        NSString *value = values[i];

        NSRange range = NSMakeRange(0, line.length);

        do {
            NSRange radar = [line rangeOfString: value
                                        options: 0
                                          range: range];

            if (radar.location == NSNotFound) break;

            pears[pearIndex].number = i + 1;
            pears[pearIndex].index = radar.location;

            pearIndex++;

            range.location = radar.location + radar.length;
            NSInteger length = line.length - range.location;
            if (length < value.length) {
                break;
            }
            range.length = length;

        } while(true);
    }

    qsort_b(pears, pearIndex, sizeof(*pears),
            ^int(const void *thing1, const void *thing2) {
                return ((Pear *)thing1)->index - ((Pear *)thing2)->index;
            });

    *outFirst = pears[0];
    *outSecond = pears[pearIndex - 1];
    
} // numberByString


int main() {
    // NSString *inputFilename = @"day-1-2-test.txt";
    NSString *inputFilename = @"day-1-prod.txt";
    NSString *input = [[NSString alloc] initWithContentsOfFile: inputFilename
                                                      encoding: NSUTF8StringEncoding
                                                         error: NULL];
    NSArray<NSString *> *lines = [input componentsSeparatedByString: @"\n"];

    NSInteger sum = 0;
    for (NSString *line in lines) {
        if (line.length == 0) continue;

        Pear pears[4];
        NSInteger pearCount = 0;

        Pear firstNumber = numberByDigit(line, forward);
        Pear secondNumber = numberByDigit(line, backward);
        if (firstNumber.number >= 1) {
            pears[pearCount] = firstNumber;
            pearCount++;
        }
        if (secondNumber.number >= 1) {
            pears[pearCount] = secondNumber;
            pearCount++;
        }

        Pear firstString, secondString;
        numberByString(line, &firstString, &secondString);

        if (firstString.number >= 1) {
            pears[pearCount] = firstString;
            pearCount++;
        }
        if (secondString.number >= 1) {
            pears[pearCount] = secondString;
            pearCount++;
        }

        qsort_b(pears, pearCount, sizeof(*pears),
                ^int(const void *thing1, const void *thing2) {
                    return ((Pear *)thing1)->index - ((Pear *)thing2)->index;
                });

        NSInteger first = pears[0].number;
        NSInteger second = pears[pearCount - 1].number;

        NSInteger value = first * 10 + second;
        if (first == 0 || second == 0) {
            NSLog(@"ZEROE");
        }
        // printf("%ld %ld %s\n", first, second, line.cString);
        sum += value;
    }

    NSLog(@"%ld", sum);

    return 0;

} // main

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
    Pear pears[10] = { { notfound, notfound } };

    for (NSInteger i = 0; i < values.count; i++) {
        NSString *value = values[i];

        NSRange radar = [line rangeOfString: value];

        pears[i].number = notfound;
        pears[i].index = notfound;
        if (radar.location != NSNotFound) {
            if (pears[i].index != notfound) {
                NSLog(@"COLLISION");
            }
            pears[i].number = i + 1;
            pears[i].index = radar.location;
        }
    }

    qsort_b(pears, sizeof(pears) / sizeof(*pears), sizeof(*pears),
            ^int(const void *thing1, const void *thing2) {
                return ((Pear *)thing1)->index - ((Pear *)thing2)->index;
            });

    *outSecond = pears[9];
    outFirst->number = notfound;
    outFirst->index = notfound;

    for (NSInteger i = 0; i < sizeof(pears) / sizeof(*pears); i++) {
        if (pears[i].index != notfound) {
            *outFirst = pears[i];
            break;
        }
    }
    
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

        Pear pears[4] = { {notfound, notfound} };

        pears[0] = numberByDigit(line, forward);
        pears[1] = numberByDigit(line, backward);

        numberByString(line, &pears[2], &pears[3]);

        qsort_b(pears, sizeof(pears) / sizeof(*pears), sizeof(*pears),
                ^int(const void *thing1, const void *thing2) {
                    return ((Pear *)thing1)->index - ((Pear *)thing2)->index;
                });

        NSInteger first = NSNotFound;
        for (NSInteger i = 0; i < 4; i++) {
            if (pears[i].index == notfound) continue;
            first = pears[i].number;
            break;
        }
        NSInteger second = pears[3].number;
        printf("%ld %ld - %s\n", first, second, line.cString);

        NSInteger value = first * 10 + second;
        sum += value;
    }

    NSLog(@"%ld", sum);

    return 0;

} // main

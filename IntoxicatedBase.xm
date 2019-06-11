#import "Headers.h"

@implementation IntoxicatedBase
+(int)getRandomNumberBetween:(int)arg1 And:(int)arg2 {
    return (int)arg1 + arc4random() % (arg2-arg1+1);
}
@end
//
//  NSObject+JKAlert.m
//  AlertAssemble
//
//  Created by 四威 on 2016/8/3.
//  Copyright © 2016年 JeanKyle. All rights reserved.
//

#import "NSObject+JKAlert.h"

@implementation NSObject (JKAlert)

- (void)eventsDelay:(NSTimeInterval)delay block:(jk_block_t)block {
    if (block) {
        [self performSelector:@selector(complyBlock:) withObject:block afterDelay:delay];
    }
}

- (void)complyBlock:(jk_block_t)block {
    if (block) {
        block();
    };
}
void mainThread(jk_block_t block) {
    if ([NSThread isMainThread]) {
        block();
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}
@end

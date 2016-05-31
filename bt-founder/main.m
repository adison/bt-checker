//
//  main.m
//  bt-founder
//
//  Created by Adison Wu on 2016/5/30.
//  Copyright © 2016年 adison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BtDelegate.h"
#define RESULT_FAIL "Result: FAIL;;\n"
#define RESULT_PASS "Result: PASS;;\n"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        __block bool keepRunning = true;
        
        __block IOBluetoothDeviceInquiry *inquiry;

        BtDelegate *a = [[BtDelegate alloc] init];
        
        NSDate *now = [NSDate date];
        NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:18];
        
        inquiry = [IOBluetoothDeviceInquiry inquiryWithDelegate:a];
        [inquiry start];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSInteger counter = 0;
            
            while(keepRunning && [[NSDate date] compare:endTime] == NSOrderedAscending) {
                if(a.devices.count > 0) {
                    keepRunning = false;
                    NSLog(@"got");
                }
                usleep(1000000);
                NSLog(@"waiting %ld s", counter++);
            }

            [inquiry stop];
            NSLog(@"\nstart: %@\n end:%@", now, endTime);
            
        });

        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:30]];
        return 0;
    }
}

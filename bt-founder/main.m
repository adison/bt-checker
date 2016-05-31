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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            inquiry = [IOBluetoothDeviceInquiry inquiryWithDelegate:a];
            [inquiry start];
            while (true) {
                if([[inquiry foundDevices] count] > 0) {
                    keepRunning = false;
                    NSLog(@"got");
                    break;
                }
                usleep(300000);
                NSLog(@"waiting for inquery");
            }
        });
        
        NSInteger counter = 0;
        NSDate *now = [NSDate date];
        NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:30];
        
        while(keepRunning && [[NSDate date] compare:endTime] == NSOrderedAscending) {
            usleep(1000000);
            if(a.devices.count > 0)
                keepRunning = false;
            NSLog(@"waiting %ld s", counter++);
        }
        NSLog(@"%@\n end:%@", now, endTime);
        
        [inquiry stop];
        
        if (a.devices.count > 0)
            printf("%s", RESULT_PASS);
        else
            printf("No such device or no divce-name. \n%s", RESULT_FAIL);
        return 0;
        
    }
}

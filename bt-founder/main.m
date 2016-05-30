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
        
        BtDelegate *a = [[BtDelegate alloc] init];
        
        IOBluetoothDeviceInquiry *inquiry = [IOBluetoothDeviceInquiry inquiryWithDelegate:a];
        [inquiry start];

        
        NSInteger counter = 0;
        NSDate *now = [NSDate date];
        NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:30];
        
        bool end =false;
        
        
        while(!end && [[NSDate date] compare:endTime] == NSOrderedAscending) {
            usleep(1000000);
            if(a.devices.count > 0)
                end = true;
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

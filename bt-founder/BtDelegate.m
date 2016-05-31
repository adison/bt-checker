//
//  BtDelegate.m
//  bt-checker
//
//  Created by Adison Wu on 2016/5/30.
//  Copyright © 2016年 Trantest. All rights reserved.
//

#import "BtDelegate.h"

@implementation BtDelegate
@synthesize devices, delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        devices = [NSArray new];
    }
    return self;
}



#pragma mark - IOBluetoothDeviceInquiryDelegate

// deviceInquiryStarted

- (void)	deviceInquiryStarted:(IOBluetoothDeviceInquiry*)sender
{
    NSLog(@"start inquiry..");
//    dispatch_async(dispatch_get_main_queue(), ^{
        self.devices = [sender foundDevices];
        [delegate found];
//    });
}

// deviceInquiryDeviceFound
- (void)	deviceInquiryDeviceFound:(IOBluetoothDeviceInquiry*)sender	device:(IOBluetoothDevice*)device
{
    NSArray *new = [self.devices arrayByAddingObject:device];
    NSLog(@"found %@", new);
    //    [self addDeviceToList:device];
    //    [_messageText setObjectValue:[NSString stringWithFormat:@"Found %d devices...", [[sender foundDevices] count]]];
//    dispatch_async(dispatch_get_main_queue(), ^{
        self.devices = [sender foundDevices];
        [delegate found];
//    });
}

// deviceInquiryUpdatingDeviceNamesStarted
- (void)	deviceInquiryUpdatingDeviceNamesStarted:(IOBluetoothDeviceInquiry*)sender	devicesRemaining:(int)devicesRemaining
{
    
//    for (NSUInteger i= 0, ii= [[sender foundDevices] count]; i< ii; i++) {
//        NSLog(@"updating device name %@", [[sender foundDevices]objectAtIndex:i]);
//    }
    //    self.devices = [sender foundDevices];
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"updating device name %@", [[sender foundDevices]objectAtIndex:0]);
        self.devices = [sender foundDevices];
        [delegate found];
//    });
}

// deviceInquiryDeviceNameUpdated

- (void)	deviceInquiryDeviceNameUpdated:(IOBluetoothDeviceInquiry*)sender	device:(IOBluetoothDevice*)device devicesRemaining:(int)devicesRemaining
{
    //    [self	updateDeviceInfoInList:device];
//    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"device name updated");
        
        self.devices = [sender foundDevices];
        [delegate found];
//    });
}

// deviceInquiryComplete
- (void)	deviceInquiryComplete:(IOBluetoothDeviceInquiry*)sender	error:(IOReturn)error	aborted:(BOOL)aborted
{
//    dispatch_async(dispatch_get_main_queue(), ^{
    
        self.devices = [sender foundDevices];
//    });
    if( aborted ) {
        NSLog(@"inquiry stopped");
    }
    else {
        NSLog(@"inquiry complete");
    }
}

-(void)test {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.devices = [self.devices arrayByAddingObject:@"yoshi!"];
    });
}
@end

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
// device Inquiry Started
- (void)	deviceInquiryStarted:(IOBluetoothDeviceInquiry*)sender
{
    NSLog(@"start inquiry..");
    self.devices = [sender foundDevices];
    [delegate found];
}

// device Inquiry Device Found
- (void)	deviceInquiryDeviceFound:(IOBluetoothDeviceInquiry*)sender	device:(IOBluetoothDevice*)device
{
    NSArray *new = [self.devices arrayByAddingObject:device];
    NSLog(@"found %@", new);
    //    [self addDeviceToList:device];
    //    [_messageText setObjectValue:[NSString stringWithFormat:@"Found %d devices...", [[sender foundDevices] count]]];
        self.devices = [sender foundDevices];
        [delegate found];

}

// device Inquiry Updating Device Names Started
- (void)	deviceInquiryUpdatingDeviceNamesStarted:(IOBluetoothDeviceInquiry*)sender	devicesRemaining:(int)devicesRemaining
{
    
//    for (NSUInteger i= 0, ii= [[sender foundDevices] count]; i< ii; i++) {
//        NSLog(@"updating device name %@", [[sender foundDevices]objectAtIndex:i]);
//    }
    //    self.devices = [sender foundDevices];
        NSLog(@"updating device name %@", [[sender foundDevices]objectAtIndex:0]);
        self.devices = [sender foundDevices];
        [delegate found];
}

// device Inquiry Device Name Updated
- (void)	deviceInquiryDeviceNameUpdated:(IOBluetoothDeviceInquiry*)sender	device:(IOBluetoothDevice*)device devicesRemaining:(int)devicesRemaining
{
//        [self	updateDeviceInfoInList:device];
        NSLog(@"device name updated");
        
        self.devices = [sender foundDevices];
        [delegate found];
}

// device Inquiry Complete
- (void)	deviceInquiryComplete:(IOBluetoothDeviceInquiry*)sender	error:(IOReturn)error	aborted:(BOOL)aborted
{
    self.devices = [sender foundDevices];
    if( aborted ) {
        NSLog(@"inquiry stopped");
    }
    else {
        NSLog(@"inquiry complete");
    }
}

@end

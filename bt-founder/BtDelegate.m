//
//  BtDelegate.m
//  bt-checker
//
//  Created by Adison Wu on 2016/5/30.
//  Copyright © 2016年 Trantest. All rights reserved.
//

#import "BtDelegate.h"

@implementation BtDelegate
@synthesize devices;

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
}

// deviceInquiryDeviceFound
- (void)	deviceInquiryDeviceFound:(IOBluetoothDeviceInquiry*)sender	device:(IOBluetoothDevice*)device
{
    NSArray *new = [self.devices arrayByAddingObject:device];
    NSLog(@"found %@", new);
    self.devices = new;
    //    [self addDeviceToList:device];
    //    [_messageText setObjectValue:[NSString stringWithFormat:@"Found %d devices...", [[sender foundDevices] count]]];
}

// deviceInquiryUpdatingDeviceNamesStarted
- (void)	deviceInquiryUpdatingDeviceNamesStarted:(IOBluetoothDeviceInquiry*)sender	devicesRemaining:(int)devicesRemaining
{
    for (NSUInteger i= 0, ii= [[sender foundDevices] count]; i< ii; i++) {
        NSLog(@"updating device name %@", [[sender foundDevices]objectAtIndex:i]);
    }
    //    self.devices = [sender foundDevices];
}

// deviceInquiryDeviceNameUpdated

- (void)	deviceInquiryDeviceNameUpdated:(IOBluetoothDeviceInquiry*)sender	device:(IOBluetoothDevice*)device devicesRemaining:(int)devicesRemaining
{
    NSLog(@"device name updated");
    //    [self	updateDeviceInfoInList:device];
}

// deviceInquiryComplete
- (void)	deviceInquiryComplete:(IOBluetoothDeviceInquiry*)sender	error:(IOReturn)error	aborted:(BOOL)aborted
{
    if( aborted ) {
        NSLog(@"inquiry stopped");
    }
    else {
        NSLog(@"inquiry complete");
    }
}
@end

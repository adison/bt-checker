//
//  BtDelegate.h
//  bt-checker
//
//  Created by Adison Wu on 2016/5/30.
//  Copyright © 2016年 Trantest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreServices/CoreServices.h>
#import <IOBluetooth/objc/IOBluetoothDeviceInquiry.h>
#import <IOBluetooth/IOBluetoothUserLib.h>
#import <IOBluetoothUI/IOBluetoothUIUserLib.h>
#import <IOBluetooth/IOBluetooth.h>
#import <IOBluetoothUI/IOBluetoothUI.h>

@protocol BtGetter

-(void)found;

@end

@interface BtDelegate : NSObject <IOBluetoothDeviceInquiryDelegate>

@property (nonatomic) NSArray *devices;
@property (weak) id<BtGetter> delegate;
@end

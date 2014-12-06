//
//  Utils.h
//  PicBlocker
//
//  Created by NhanB on 12/1/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject

+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)isFullVersion;
+ (void)showAlertWithMessage:(NSString *)message;

+ (BOOL)isFirstTimeLaunchApp;
+ (NSString *)getPasscode;
+ (void)setPasscodeWithCode:(NSString *)passcode;
+ (NSString *)nameForImage;
+ (NSString *)pathForImageWithName:(NSString *)name;

@end

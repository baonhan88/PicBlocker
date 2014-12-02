//
//  Utils.h
//  PicBlocker
//
//  Created by NhanB on 12/1/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (BOOL)validateEmail:(NSString *)email;

+ (BOOL)isFirstTimeLaunchApp;
+ (NSString *)getPasscode;
+ (void)setPasscodeWithCode:(NSString *)passcode;

@end

//
//  Utils.m
//  PicBlocker
//
//  Created by NhanB on 12/1/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "Utils.h"

#define kIsFirstLaunchApp   @"kIsFirstLaunchApp"
#define kPasscode           @"kPasscode"

@interface Utils()

@end

@implementation Utils

+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
    return [emailTest evaluateWithObject:email];
}

#pragma mark - User Defaults

+ (BOOL)isFirstTimeLaunchApp {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:kIsFirstLaunchApp]) {
        [userDefaults setBool:YES forKey:kIsFirstLaunchApp];
        [userDefaults synchronize];
        
        return YES;
    }
    
    return NO;
}

+ (NSString *)getPasscode {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:kPasscode]) {
        return [userDefaults objectForKey:kPasscode];
    }
    
    return nil;
}

+ (void)setPasscodeWithCode:(NSString *)passcode {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:passcode forKey:kPasscode];
    [userDefaults synchronize];
}

+ (NSString *)nameForImage {
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    
}

@end

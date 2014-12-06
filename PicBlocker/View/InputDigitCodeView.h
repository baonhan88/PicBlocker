//
//  InputDigitCodeView.h
//  PicBlocker
//
//  Created by NhanB on 12/6/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputDigitCodeDelegate <NSObject>

- (void)processInputDigitDone;
- (void)digitCodeViewClosed;

@end

@interface InputDigitCodeView : UIView

@property (assign, nonatomic) id<InputDigitCodeDelegate> delegate;

@end

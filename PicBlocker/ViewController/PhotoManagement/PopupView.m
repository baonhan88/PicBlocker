//
//  PopupView.m
//  PicBlocker
//
//  Created by NhanB on 12/4/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "PopupView.h"

@implementation PopupView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)importButtonClicked:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(importButtonClicked)]) {
        [_delegate importButtonClicked];
    }
}

- (IBAction)settingButtonClicked:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(settingButtonClicked)]) {
        [_delegate settingButtonClicked];
    }
}

@end

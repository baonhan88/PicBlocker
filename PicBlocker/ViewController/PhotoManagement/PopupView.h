//
//  PopupView.h
//  PicBlocker
//
//  Created by NhanB on 12/4/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupDelegate <NSObject>

- (void)importButtonClicked;
- (void)settingButtonClicked;

@end

@interface PopupView : UIView

@property (assign, nonatomic) id<PopupDelegate> delegate;

@end

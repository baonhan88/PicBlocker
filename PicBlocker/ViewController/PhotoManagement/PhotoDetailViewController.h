//
//  PhotoDetailViewController.h
//  PicBlocker
//
//  Created by NhanB on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupView.h"
#import "PhotoEntity.h"
#import "InputDigitCodeView.h"

@interface PhotoDetailViewController : UIViewController <PopupDelegate, InputDigitCodeDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) PhotoEntity *photoEntity;

@end

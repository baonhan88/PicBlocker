//
//  SettingViewController.h
//  PicBlocker
//
//  Created by NhanB on 12/6/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kDigitType = 0,
    kDigitNewType,
    kDigitRepeatType
} kDigitCodeType;

@interface SettingViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@end

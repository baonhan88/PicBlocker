//
//  RegisterEmailView.m
//  PicBlocker
//
//  Created by Nhan Bao on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "RegisterEmailView.h"

@interface RegisterEmailView ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation RegisterEmailView

- (void)awakeFromNib {
    _emailTextField.layer.borderColor = [UIColor whiteColor].CGColor;
    _emailTextField.layer.borderWidth = 1;
    
    [_emailTextField becomeFirstResponder];
}

#pragma mark - Events

- (IBAction)goButtonClicked:(id)sender {
    NSString *errorMessageString = @"";
    
    if ([_emailTextField.text isEqualToString:@""]) {
        errorMessageString = @"Please input email";
    } else if (![Utils validateEmail:_emailTextField.text]) {
        errorMessageString = @"Invalid email address";
    }
    
    if (![errorMessageString isEqualToString:@""]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:errorMessageString
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        // set up new email address
        
        // next screen
//        SetupDigitCodeViewController *setupDigitCodeVC = [[SetupDigitCodeViewController alloc] initWithNibName:@"SetupDigitCodeViewController" bundle:nil];
//        [self.navigationController pushViewController:setupDigitCodeVC animated:YES];
        
    }
}

@end

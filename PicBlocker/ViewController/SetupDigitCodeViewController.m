//
//  SetupDigitCodeViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/1/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "SetupDigitCodeViewController.h"

@interface SetupDigitCodeViewController ()

@property (strong, nonatomic) IBOutlet UITextField *digitCodeTextField;

@property (strong, nonatomic) NSString *digitCodeString;


@end

@implementation SetupDigitCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_digitCodeTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_digitCodeTextField.text.length >= 3) {
        if (!_digitCodeString) {
            _digitCodeString = _digitCodeTextField.text;
            _digitCodeTextField.text = @"";
        } else {
            if ([_digitCodeTextField.text isEqualToString:_digitCodeString]) {
                DLog(@"digit done");
                // setup four digit code
                
                // next screen
            } else {
                
            }
            
        }
        
        return NO;
    }
    
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  SetupDigitCodeViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/1/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "SetupDigitCodeViewController.h"

@interface SetupDigitCodeViewController ()

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

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
    DLog(@"textField.text = %@", textField.text);
    DLog(@"string = %@", string);
    
    NSString *digitString = [NSString stringWithFormat:@"%@%@", textField.text, string];
    
    if (digitString.length >= 4) {
        if (!_digitCodeString) {
            _digitCodeString = digitString;
            _digitCodeTextField.text = @"";
            _descriptionLabel.text = @"Please re-enter or setup your four digit code";
        } else {
            if ([digitString isEqualToString:_digitCodeString]) {
                DLog(@"digit done");
                // setup four digit code
                
                // next screen
            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                                    message:@"Digit code not matched, please try again"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                [alertView show];
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

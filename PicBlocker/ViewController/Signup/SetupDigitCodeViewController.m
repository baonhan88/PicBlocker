//
//  SetupDigitCodeViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/1/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "SetupDigitCodeViewController.h"
#import "SecurityQuestionViewController.h"
#import "PhotoManagementViewController.h"

@interface SetupDigitCodeViewController ()

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) IBOutlet UITextField *digitCodeTextField;

@property (strong, nonatomic) NSString *digitCodeString;


@end

@implementation SetupDigitCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _digitCodeTextField.delegate = self;
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

#pragma mark - Events

- (IBAction)digitCodeTextFieldEditingChanged:(id)sender {
    // nhap du 4 ky tu -> bat dau check
    // neu chua setup digit
    // nhap lan 1 thi cho nhap lan 2 ky tu
    // nguoc lai thi kiem tra 2 chuoi lan 1 va 2 co khop voi nhau ko
    // neu khop thi save passcode -> next qua man hinh setup Q&A
    // nguoc lai show alert error, reset digit nhap lai lan 2
    // nguoc lai cho qua man hinh list Photo
    
    if (_digitCodeTextField.text.length >= 4) {
        if (![Utils getPasscode]) {
            if (!_digitCodeString) {
                _digitCodeString = _digitCodeTextField.text;
                _digitCodeTextField.text = @"";
                _descriptionLabel.text = @"Please re-enter or setup your four digit code";
            } else {
                if ([_digitCodeTextField.text isEqualToString:_digitCodeString]) {
                    DLog(@"digit done");
                    // setup four digit code
                    [Utils setPasscodeWithCode:_digitCodeString];
                    
                    // go to security question screen
                    SecurityQuestionViewController *securityQuestionVC = [[SecurityQuestionViewController alloc] initWithNibName:@"SecurityQuestionViewController" bundle:nil];
                    [self.navigationController pushViewController:securityQuestionVC animated:YES];
                } else {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                                        message:@"Digit code not matched, please try again"
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil, nil];
                    [alertView show];
                    
                    _digitCodeTextField.text = @"";
                }
                
            }
            
        } else {
            // go to photo list screen
            PhotoManagementViewController *photoManagementVC = [[PhotoManagementViewController alloc] initWithNibName:@"PhotoManagementViewController" bundle:nil];
            [self.navigationController pushViewController:photoManagementVC animated:YES];
        }
        
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length >= 4) {
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

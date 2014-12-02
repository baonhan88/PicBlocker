//
//  SetupEmailViewController.m
//  PicBlocker
//
//  Created by Nhan Bao on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "SetupEmailViewController.h"
#import "SetupDigitCodeViewController.h"

@interface SetupEmailViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation SetupEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _emailTextField.leftView = spaceView;
    _emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
//    _emailTextField.layer.borderColor = [UIColor whiteColor].CGColor;
//    _emailTextField.layer.borderWidth = 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_emailTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SetupDigitCodeViewController *setupDigitVC = [storyboard instantiateViewControllerWithIdentifier:@"SetupDigitCodeViewController"];
        [self.navigationController pushViewController:setupDigitVC animated:YES];

        
    }
}


@end

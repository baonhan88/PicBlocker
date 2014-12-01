//
//  ViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/1/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "ViewController.h"
#import "SetupDigitCodeViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
        SetupDigitCodeViewController *setupDigitCodeVC = [[SetupDigitCodeViewController alloc] initWithNibName:@"SetupDigitCodeViewController" bundle:nil];
        [self.navigationController pushViewController:setupDigitCodeVC animated:YES];
        
    }
}


@end

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

#define kBackspaceButtonTag             20

@interface SetupDigitCodeViewController ()

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) IBOutlet UIView *digitBorder1View;
@property (strong, nonatomic) IBOutlet UIView *digitBorder2View;
@property (strong, nonatomic) IBOutlet UIView *digitBorder3View;
@property (strong, nonatomic) IBOutlet UIView *digitBorder4View;

@property (strong, nonatomic) IBOutlet UIImageView *dotImage1View;
@property (strong, nonatomic) IBOutlet UIImageView *dotImage2View;
@property (strong, nonatomic) IBOutlet UIImageView *dotImage3View;
@property (strong, nonatomic) IBOutlet UIImageView *dotImage4View;

@property (strong, nonatomic) NSString *digitCodeString;
@property (strong, nonatomic) NSString *oldDigitCodeStringSaved;

@end

@implementation SetupDigitCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _digitCodeString = @"";
    _oldDigitCodeStringSaved = @"";
    
    // init input digit code view
    _digitBorder1View.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6].CGColor;
    _digitBorder1View.layer.borderWidth = 1;
    
    _digitBorder2View.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6].CGColor;
    _digitBorder2View.layer.borderWidth = 1;
    
    _digitBorder3View.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6].CGColor;
    _digitBorder3View.layer.borderWidth = 1;
    
    _digitBorder4View.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6].CGColor;
    _digitBorder4View.layer.borderWidth = 1;
    
    _dotImage1View.hidden = YES;
    _dotImage2View.hidden = YES;
    _dotImage3View.hidden = YES;
    _dotImage4View.hidden = YES;
    
    // init the number keyboard
    [self initKeyboard];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [_digitCodeTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Common Methods

- (void)initKeyboard {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    int widthOfButton = size.width/3;
    int heightOfButton = 45;
    float yStart = size.height - heightOfButton*4;
    int count = 0;
    
    for (int i=0; i<4; i++) {
        for (int j=0; j<3; j++) {
            count++;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(j*widthOfButton, yStart + i*heightOfButton, widthOfButton, heightOfButton);
            [button addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:30];
            
            if (i == 3) {
                if (j == 0) {
                    // add non-button
                    [button setTitle:@"" forState:UIControlStateNormal];
                    button.userInteractionEnabled = NO;
                } else if (j == 1) {
                    [button setTitle:@"0" forState:UIControlStateNormal];
                    button.tag = 0;
                } else {
                    // add backspace button
                    [button setImage:[UIImage imageNamed:@"back_space_icon"] forState:UIControlStateNormal];
                    button.tag = kBackspaceButtonTag;
                }
            } else {
                [button setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
                button.tag = count;
            }
            
            [self.view addSubview:button];

            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
        }
    }
}

- (void)updateDigitDot {
    if (_digitCodeString.length == 0) {
        _dotImage1View.hidden = YES;
        _dotImage2View.hidden = YES;
        _dotImage3View.hidden = YES;
        _dotImage4View.hidden = YES;
    } else if (_digitCodeString.length == 1) {
        _dotImage1View.hidden = NO;
        _dotImage2View.hidden = YES;
        _dotImage3View.hidden = YES;
        _dotImage4View.hidden = YES;
    } else if (_digitCodeString.length == 2) {
        _dotImage1View.hidden = NO;
        _dotImage2View.hidden = NO;
        _dotImage3View.hidden = YES;
        _dotImage4View.hidden = YES;
    } else if (_digitCodeString.length == 3) {
        _dotImage1View.hidden = NO;
        _dotImage2View.hidden = NO;
        _dotImage3View.hidden = NO;
        _dotImage4View.hidden = YES;
    } else if (_digitCodeString.length >= 4) {
        _dotImage1View.hidden = NO;
        _dotImage2View.hidden = NO;
        _dotImage3View.hidden = NO;
        _dotImage4View.hidden = NO;
    }
}

- (void)checkDigitCode {
    // nhap du 4 ky tu -> bat dau check
    // neu chua setup digit
    // nhap lan 1 thi cho nhap lan 2 ky tu
    // nguoc lai thi kiem tra 2 chuoi lan 1 va 2 co khop voi nhau ko
    // neu khop thi save passcode -> next qua man hinh setup Q&A
    // nguoc lai show alert error, reset digit nhap lai lan 2
    // nguoc lai cho qua man hinh list Photo
    
    [self updateDigitDot];
    
    if (_digitCodeString.length >= 4) {
        if (![Utils getPasscode]) {
            if ([_oldDigitCodeStringSaved isEqualToString:@""]) {
                _oldDigitCodeStringSaved = _digitCodeString;
                
                _digitCodeString = @"";
                [self updateDigitDot];
                
                _descriptionLabel.text = @"Please re-enter or setup your four digit code";
            } else {
                if ([_digitCodeString isEqualToString:_oldDigitCodeStringSaved]) {
                    DLog(@"digit done");
                    // setup four digit code
                    [Utils setPasscodeWithCode:_digitCodeString];
                    
                    // go to security question screen
                    SecurityQuestionViewController *securityQuestionVC = [[SecurityQuestionViewController alloc] initWithNibName:@"SecurityQuestionViewController" bundle:nil];
                    [self.navigationController pushViewController:securityQuestionVC animated:YES];
                } else {
                    // re-input digit code
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                                        message:@"Digit code is not matched, please try again"
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil, nil];
                    [alertView show];
                    
                    _digitCodeString = @"";
                    [self updateDigitDot];
                }
                
            }
            
        } else {
            if ([_digitCodeString isEqualToString:[Utils getPasscode]]) {
                // go to photo list screen
                PhotoManagementViewController *photoManagementVC = [[PhotoManagementViewController alloc] initWithNibName:@"PhotoManagementViewController" bundle:nil];
                [self.navigationController pushViewController:photoManagementVC animated:YES];
            } else {
                // re-input digit code
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                                    message:@"Digit code not matched, please try again"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                [alertView show];
                
                _digitCodeString = @"";
                [self updateDigitDot];
            }
        }
        
    }
}

#pragma mark - Events

- (void)numberButtonClicked:(UIButton *)sender {
    DLog(@"clicked on button with tag = %ld", sender.tag);
    if (sender.tag == kBackspaceButtonTag) {
        // process backspace
        if ([_digitCodeString length] > 0) {
            _digitCodeString = [_digitCodeString substringToIndex:[_digitCodeString length] - 1];
            [self checkDigitCode];
        }
    } else {
        // process click number button
        _digitCodeString = [NSString stringWithFormat:@"%@%ld", _digitCodeString, sender.tag];
        [self checkDigitCode];
    }
}

- (IBAction)forgotCodeButtonClicked:(id)sender {
    
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

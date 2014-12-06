//
//  SettingViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/6/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "SettingViewController.h"
#import "NumberKeyboardView.h"

#define kBackspaceButtonTag             20

@interface SettingViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

// for code
@property (strong, nonatomic) IBOutlet UIView *digitBorder1View;
@property (strong, nonatomic) IBOutlet UIView *digitBorder2View;
@property (strong, nonatomic) IBOutlet UIView *digitBorder3View;
@property (strong, nonatomic) IBOutlet UIView *digitBorder4View;

@property (strong, nonatomic) IBOutlet UIImageView *digitDot1Image;
@property (strong, nonatomic) IBOutlet UIImageView *digitDot2Image;
@property (strong, nonatomic) IBOutlet UIImageView *digitDot3Image;
@property (strong, nonatomic) IBOutlet UIImageView *digitDot4Image;

// for new code
@property (strong, nonatomic) IBOutlet UIView *digitNewBorder1View;
@property (strong, nonatomic) IBOutlet UIView *digitNewBorder2View;
@property (strong, nonatomic) IBOutlet UIView *digitNewBorder3View;
@property (strong, nonatomic) IBOutlet UIView *digitNewBorder4View;

@property (strong, nonatomic) IBOutlet UIImageView *digitNewDot1Image;
@property (strong, nonatomic) IBOutlet UIImageView *digitNewDot2Image;
@property (strong, nonatomic) IBOutlet UIImageView *digitNewDot3Image;
@property (strong, nonatomic) IBOutlet UIImageView *digitNewDot4Image;

// for repeat code
@property (strong, nonatomic) IBOutlet UIView *digitRepeatBorder1View;
@property (strong, nonatomic) IBOutlet UIView *digitRepeatBorder2View;
@property (strong, nonatomic) IBOutlet UIView *digitRepeatBorder3View;
@property (strong, nonatomic) IBOutlet UIView *digitRepeatBorder4View;

@property (strong, nonatomic) IBOutlet UIImageView *digitRepeatDot1Image;
@property (strong, nonatomic) IBOutlet UIImageView *digitRepeatDot2Image;
@property (strong, nonatomic) IBOutlet UIImageView *digitRepeatDot3Image;
@property (strong, nonatomic) IBOutlet UIImageView *digitRepeatDot4Image;

// for text field
@property (strong, nonatomic) IBOutlet UITextField *questionTextField;
@property (strong, nonatomic) IBOutlet UITextField *answerTextField;

@property (strong, nonatomic) NSString *digitString;
@property (strong, nonatomic) NSString *digitNewString;
@property (strong, nonatomic) NSString *digitRepeatString;

@property (strong, nonatomic) UIPickerView *questionPicker;

@property (strong, nonatomic) NSMutableArray *questionList;

@property (assign, nonatomic) kDigitCodeType digitCodeType;

@property (strong, nonatomic) UIView *numberKeyboardView;
@property (strong, nonatomic) UIView *questionPickerView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"PicBlocker";
    
    _digitString = @"";
    _digitNewString = @"";
    _digitRepeatString = @"";
    
    // init input digit code view
    [self initInputDigitCode];
    
    // init all text field
    [self initTextField];
    
    // init number keyboard view
    [self initKeyboard];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Common Methods

- (void)initKeyboard {
    CGSize size = [[UIScreen mainScreen] bounds].size;
    
    _numberKeyboardView = [[UIView alloc] initWithFrame:CGRectMake(0, size.height-180, size.width, 180)];
    [_numberKeyboardView setBackgroundColor:[UIColor colorWithRed:43.0/255.0 green:108.0/255.0 blue:71.0/255.0 alpha:1.0]];
    [self.view addSubview:_numberKeyboardView];
    
    int widthOfButton = size.width/3;
    int heightOfButton = 45;
    int count = 0;
    
    for (int i=0; i<4; i++) {
        for (int j=0; j<3; j++) {
            count++;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(j*widthOfButton, i*heightOfButton, widthOfButton, heightOfButton);
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
            
            [_numberKeyboardView addSubview:button];
            
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
        }
    }
    
    _numberKeyboardView.hidden = YES;
}

- (void)updateDigitDot {
    if (_digitCodeType == kDigitType) {
        if (_digitString.length == 0) {
            _digitDot1Image.hidden = YES;
            _digitDot2Image.hidden = YES;
            _digitDot3Image.hidden = YES;
            _digitDot4Image.hidden = YES;
        } else if (_digitString.length == 1) {
            _digitDot1Image.hidden = NO;
            _digitDot2Image.hidden = YES;
            _digitDot3Image.hidden = YES;
            _digitDot4Image.hidden = YES;
        } else if (_digitString.length == 2) {
            _digitDot1Image.hidden = NO;
            _digitDot2Image.hidden = NO;
            _digitDot3Image.hidden = YES;
            _digitDot4Image.hidden = YES;
        } else if (_digitString.length == 3) {
            _digitDot1Image.hidden = NO;
            _digitDot2Image.hidden = NO;
            _digitDot3Image.hidden = NO;
            _digitDot4Image.hidden = YES;
        } else if (_digitString.length >= 4) {
            _digitDot1Image.hidden = NO;
            _digitDot2Image.hidden = NO;
            _digitDot3Image.hidden = NO;
            _digitDot4Image.hidden = NO;
        }
    } else if (_digitCodeType == kDigitNewType) {
        if (_digitNewString.length == 0) {
            _digitNewDot1Image.hidden = YES;
            _digitNewDot2Image.hidden = YES;
            _digitNewDot3Image.hidden = YES;
            _digitNewDot4Image.hidden = YES;
        } else if (_digitNewString.length == 1) {
            _digitNewDot1Image.hidden = NO;
            _digitNewDot2Image.hidden = YES;
            _digitNewDot3Image.hidden = YES;
            _digitNewDot4Image.hidden = YES;
        } else if (_digitNewString.length == 2) {
            _digitNewDot1Image.hidden = NO;
            _digitNewDot2Image.hidden = NO;
            _digitNewDot3Image.hidden = YES;
            _digitNewDot4Image.hidden = YES;
        } else if (_digitNewString.length == 3) {
            _digitNewDot1Image.hidden = NO;
            _digitNewDot2Image.hidden = NO;
            _digitNewDot3Image.hidden = NO;
            _digitNewDot4Image.hidden = YES;
        } else if (_digitNewString.length >= 4) {
            _digitNewDot1Image.hidden = NO;
            _digitNewDot2Image.hidden = NO;
            _digitNewDot3Image.hidden = NO;
            _digitNewDot4Image.hidden = NO;
        }
    } else if (_digitCodeType == kDigitRepeatType) {
        if (_digitRepeatString.length == 0) {
            _digitRepeatDot1Image.hidden = YES;
            _digitRepeatDot2Image.hidden = YES;
            _digitRepeatDot3Image.hidden = YES;
            _digitRepeatDot4Image.hidden = YES;
        } else if (_digitRepeatString.length == 1) {
            _digitRepeatDot1Image.hidden = NO;
            _digitRepeatDot2Image.hidden = YES;
            _digitRepeatDot3Image.hidden = YES;
            _digitRepeatDot4Image.hidden = YES;
        } else if (_digitRepeatString.length == 2) {
            _digitRepeatDot1Image.hidden = NO;
            _digitRepeatDot2Image.hidden = NO;
            _digitRepeatDot3Image.hidden = YES;
            _digitRepeatDot4Image.hidden = YES;
        } else if (_digitRepeatString.length == 3) {
            _digitRepeatDot1Image.hidden = NO;
            _digitRepeatDot2Image.hidden = NO;
            _digitRepeatDot3Image.hidden = NO;
            _digitRepeatDot4Image.hidden = YES;
        } else if (_digitRepeatString.length >= 4) {
            _digitRepeatDot1Image.hidden = NO;
            _digitRepeatDot2Image.hidden = NO;
            _digitRepeatDot3Image.hidden = NO;
            _digitRepeatDot4Image.hidden = NO;
        }
    }
    
}

- (void)initTextField {
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
        
    // add right button for question textField
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 50);
    [rightButton setImage:[UIImage imageNamed:@"updown_arrow_Screen_10"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    _questionTextField.rightView = rightButton;
    _questionTextField.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *spaceView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _questionTextField.leftView = spaceView1;
    _questionTextField.leftViewMode = UITextFieldViewModeAlways;

    UIView *spaceView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _answerTextField.leftView = spaceView2;
    _answerTextField.leftViewMode = UITextFieldViewModeAlways;
    
    // init question list
    _questionList = [[NSMutableArray alloc] init];
    [_questionList addObject:@"What's your name?"];
    [_questionList addObject:@"What's the first pet name?"];
    [_questionList addObject:@"How old are you?"];
    [_questionList addObject:@"Where are you from?"];
    [_questionList addObject:@"What's your best friend name?"];
    [_questionList addObject:@"What's your University name?"];
    
    _questionPicker = [UIPickerView new];
    _questionPicker.frame = CGRectMake(0, 0, winSize.width, 162);
    _questionPicker.delegate = self;
    _questionPicker.dataSource = self;
    [_questionPicker reloadComponent:0];
    
    _questionPickerView = [[UIView alloc] initWithFrame:CGRectMake(0, winSize.height-162, winSize.width, 162)];
    [_questionPickerView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_questionPickerView];
    
    [_questionPickerView addSubview:_questionPicker];
    _questionPickerView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)initInputDigitCode {
    // init code
    _digitBorder1View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitBorder1View.layer.borderWidth = 1;
    
    _digitBorder2View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitBorder2View.layer.borderWidth = 1;
    
    _digitBorder3View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitBorder3View.layer.borderWidth = 1;
    
    _digitBorder4View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitBorder4View.layer.borderWidth = 1;
    
    _digitDot1Image.hidden = YES;
    _digitDot2Image.hidden = YES;
    _digitDot3Image.hidden = YES;
    _digitDot4Image.hidden = YES;
    
    // init new code
    _digitNewBorder1View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitNewBorder1View.layer.borderWidth = 1;
    
    _digitNewBorder2View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitNewBorder2View.layer.borderWidth = 1;
    
    _digitNewBorder3View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitNewBorder3View.layer.borderWidth = 1;
    
    _digitNewBorder4View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitNewBorder4View.layer.borderWidth = 1;
    
    _digitNewDot1Image.hidden = YES;
    _digitNewDot2Image.hidden = YES;
    _digitNewDot3Image.hidden = YES;
    _digitNewDot4Image.hidden = YES;
    
    // init repeat code
    _digitRepeatBorder1View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitRepeatBorder1View.layer.borderWidth = 1;
    
    _digitRepeatBorder2View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitRepeatBorder2View.layer.borderWidth = 1;
    
    _digitRepeatBorder3View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitRepeatBorder3View.layer.borderWidth = 1;
    
    _digitRepeatBorder4View.layer.borderColor = [UIColor colorWithRed:165.0/255.0 green:212.0/255.0 blue:186.0/255.0 alpha:1.0].CGColor;
    _digitRepeatBorder4View.layer.borderWidth = 1;
    
    _digitRepeatDot1Image.hidden = YES;
    _digitRepeatDot2Image.hidden = YES;
    _digitRepeatDot3Image.hidden = YES;
    _digitRepeatDot4Image.hidden = YES;
}

- (void)showQuestionPickerView {
    _questionPickerView.hidden = NO;
}

- (void)hideQuestionPickerView {
    _questionPickerView.hidden = YES;
}

- (BOOL)isValidAllField {
    if (_digitString.length < 4) {
        [Utils showAlertWithMessage:@"Please input code with four digit"];
        
        return NO;
    }
    
    if (_digitNewString.length < 4) {
        [Utils showAlertWithMessage:@"Please input new code with four digit"];
        
        return NO;
    }
    
    if (_digitRepeatString.length < 4) {
        [Utils showAlertWithMessage:@"Please input repeat code with four digit"];
        
        return NO;
    }
    
    if (![_digitString isEqualToString:[Utils getPasscode]]) {
        _digitString = @"";
        _digitCodeType = kDigitType;
        [self updateDigitDot];
        
        [Utils showAlertWithMessage:@"Wrong digit code"];
        
        return NO;
    }
    
    if (![_digitNewString isEqualToString:_digitRepeatString]) {
        _digitNewString = @"";
        _digitCodeType = kDigitNewType;
        [self updateDigitDot];

        _digitRepeatString = @"";
        _digitCodeType = kDigitRepeatType;
        [self updateDigitDot];

        [Utils showAlertWithMessage:@"Digit code is not matched, please try again"];
        
        return NO;
    }
    
    if ([_questionTextField.text isEqualToString:@""]) {
        [Utils showAlertWithMessage:@"Please choose security question"];
        
        return NO;
    }
    
    if ([_answerTextField.text isEqualToString:@""]) {
        [Utils showAlertWithMessage:@"Please input answer"];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Events

- (IBAction)saveButtonClicked:(UIButton *)sender {
    [self hideQuestionPickerView];
    _numberKeyboardView.hidden = YES;
    
    if ([self isValidAllField]) {
        // call API to update setting
        
        [Utils showAlertWithMessage:@"Setting updated"];
    }
}

- (IBAction)cancelButtonClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)digitButtonClicked:(id)sender {
    [self hideQuestionPickerView];
    
    _digitCodeType = kDigitType;
    
    _numberKeyboardView.hidden = NO;
}

- (IBAction)digitNewButtonClicked:(id)sender {
    [self hideQuestionPickerView];

    _digitCodeType = kDigitNewType;
    
    _numberKeyboardView.hidden = NO;
}

- (IBAction)digitRepeatButtonClicked:(id)sender {
    [self hideQuestionPickerView];

    _digitCodeType = kDigitRepeatType;
    
    _numberKeyboardView.hidden = NO;
}

- (void)numberButtonClicked:(UIButton *)sender {
    switch (_digitCodeType) {
        case kDigitType:
            if (sender.tag == kBackspaceButtonTag) {
                // process backspace
                if ([_digitString length] > 0) {
                    _digitString = [_digitString substringToIndex:[_digitString length] - 1];
                }
            } else {
                if (_digitString.length >= 4) {
                    return;
                }
                // process click number button
                _digitString = [NSString stringWithFormat:@"%@%d", _digitString, (int)sender.tag];
            }
            break;
            
        case kDigitNewType:
            if (sender.tag == kBackspaceButtonTag) {
                // process backspace
                if ([_digitNewString length] > 0) {
                    _digitNewString = [_digitNewString substringToIndex:[_digitNewString length] - 1];
                }
            } else {
                if (_digitNewString.length >= 4) {
                    return;
                }
                // process click number button
                _digitNewString = [NSString stringWithFormat:@"%@%d", _digitNewString, (int)sender.tag];
            }
            break;
            
        case kDigitRepeatType:
            if (sender.tag == kBackspaceButtonTag) {
                // process backspace
                if ([_digitRepeatString length] > 0) {
                    _digitRepeatString = [_digitRepeatString substringToIndex:[_digitRepeatString length] - 1];
                }
            } else {
                if (_digitRepeatString.length >= 4) {
                    return;
                }
                // process click number button
                _digitRepeatString = [NSString stringWithFormat:@"%@%d", _digitRepeatString, (int)sender.tag];
            }
            break;
            
        default:
            break;
    }
    
    // update digit dot
    [self updateDigitDot];
}

- (void)rightButtonClicked:(id)sender {
    _numberKeyboardView.hidden = YES;
    
    // show question picker view
    [self showQuestionPickerView];
}

- (void)tapOnView {
    if (!_numberKeyboardView.hidden) {
        _numberKeyboardView.hidden = YES;
    } else {
        [self hideQuestionPickerView];
        
        _questionTextField.text = [_questionList objectAtIndex:[_questionPicker selectedRowInComponent:0]];
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return _questionList.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_questionList objectAtIndex:row];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //Here, like the table view you can get the each section of each row if you've multiple sections
    DLog(@"Selected Question: %@", [_questionList objectAtIndex:row]);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _questionTextField) {
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _questionTextField) {
        [self showQuestionPickerView];
        return;
    }
    
    [textField becomeFirstResponder];
    
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
    
    CGPoint position = CGPointMake(0, textField.frame.origin.y-(winSize.height-360));
    [_scrollView setContentOffset:position animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [_scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
    
    return YES;
}

@end

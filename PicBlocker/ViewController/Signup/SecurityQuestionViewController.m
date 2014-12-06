//
//  SecurityQuestionViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "SecurityQuestionViewController.h"
#import "PhotoManagementViewController.h"

@interface SecurityQuestionViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITextField *questionTextField;
@property (strong, nonatomic) IBOutlet UITextField *answerTextField;

@property (strong, nonatomic) IBOutlet UIButton *goButton;


@property (strong, nonatomic) UIPickerView *questionPicker;

@property (strong, nonatomic) NSMutableArray *questionList;

@end

@implementation SecurityQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
    
    // add right button for question textField
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 50);
    [rightButton setImage:[UIImage imageNamed:@"Up_Down_arrow"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    _questionTextField.rightView = rightButton;
    _questionTextField.rightViewMode = UITextFieldViewModeAlways;
    
    // init question list
    _questionList = [[NSMutableArray alloc] init];
    [_questionList addObject:@"What's your name?"];
    [_questionList addObject:@"What's the first pet name?"];
    [_questionList addObject:@"How old are you?"];
    [_questionList addObject:@"Where are you from?"];
    [_questionList addObject:@"What's your best friend name?"];
    [_questionList addObject:@"What's your University name?"];
    
    _questionPicker = [UIPickerView new];
    _questionPicker.frame = CGRectMake(0, winSize.height-162, winSize.width, 162);
    _questionPicker.delegate = self;
    _questionPicker.dataSource = self;
    [_questionPicker reloadComponent:0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _questionTextField.leftView = spaceView;
    _questionTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *spaceView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _answerTextField.leftView = spaceView1;
    _answerTextField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Common Methods

- (void)showQuestionPickerView {
    [self.view addSubview:_questionPicker];
}

- (void)hideQuestionPickerView {
    [_questionPicker removeFromSuperview];
}

#pragma mark - Events

- (IBAction)goButtonClicked:(id)sender {
    // go to photo list screen
    PhotoManagementViewController *photoManagementVC = [[PhotoManagementViewController alloc] initWithNibName:@"PhotoManagementViewController" bundle:nil];
    [self.navigationController pushViewController:photoManagementVC animated:YES];
}

- (void)rightButtonClicked:(id)sender {
    // show question picker view
    [self showQuestionPickerView];
}

- (void)tapOnView {
    [self hideQuestionPickerView];
    
    _questionTextField.text = [_questionList objectAtIndex:[_questionPicker selectedRowInComponent:0]];
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
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
    
    CGPoint position = CGPointMake(0, textField.frame.origin.y-(winSize.height-280));
    [_scrollView setContentOffset:position animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [_scrollView setContentOffset:CGPointZero animated:YES];
    
    return YES;
}

@end

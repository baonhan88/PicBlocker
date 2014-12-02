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

@end

@implementation SecurityQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark - Events

- (IBAction)goButtonClicked:(id)sender {
    // go to photo list screen
    PhotoManagementViewController *photoManagementVC = [[PhotoManagementViewController alloc] initWithNibName:@"PhotoManagementViewController" bundle:nil];
    [self.navigationController pushViewController:photoManagementVC animated:YES];
}

@end

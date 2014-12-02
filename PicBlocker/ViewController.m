//
//  ViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/1/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "ViewController.h"
#import "SetupEmailViewController.h"
#import "SetupDigitCodeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if ([Utils isFirstTimeLaunchApp]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SetupEmailViewController *setupEmailVC = [storyboard instantiateViewControllerWithIdentifier:@"SetupEmailViewController"];
        [self.navigationController pushViewController:setupEmailVC animated:NO];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SetupDigitCodeViewController *setupDigitVC = [storyboard instantiateViewControllerWithIdentifier:@"SetupDigitCodeViewController"];
        [self.navigationController pushViewController:setupDigitVC animated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

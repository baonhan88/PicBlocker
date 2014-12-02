//
//  PhotoDetailViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()

@property (strong, nonatomic) IBOutlet UIView *importSettingView;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _importSettingView.hidden = YES;
    
    // init navigation bar
    self.title = @"Pic Blocker";
    
    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_cam_icon"]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(cameraButtonClicked:)];
    UIBarButtonItem *importSettingButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"header_setting_icon"]
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(importSettingButtonClicked:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:importSettingButton, cameraButton, nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Events

- (void)cameraButtonClicked:(id)sender {
    DLog(@"cameraButtonClicked");
}

- (void)importSettingButtonClicked:(id)sender {
    DLog(@"importSettingButtonClicked");
    _importSettingView.hidden = !_importSettingView.hidden;
}

@end

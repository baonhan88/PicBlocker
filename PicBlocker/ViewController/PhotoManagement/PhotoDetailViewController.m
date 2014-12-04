//
//  PhotoDetailViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()

@property (strong, nonatomic) PopupView *popupView;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
    
    // add image full screen
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"splash_screen"]];
    _imageView.frame = CGRectMake(0, 64, winSize.width, winSize.height-44-64);
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    // init popup view
    _popupView = [[[NSBundle mainBundle] loadNibNamed:@"PopupView" owner:self options:nil] objectAtIndex:0];
    _popupView.frame = CGRectMake(winSize.width - _popupView.frame.size.width, 64, _popupView.frame.size.width, _popupView.frame.size.height);
    _popupView.delegate = self;
    [self.view addSubview:_popupView];
    _popupView.hidden = YES;
    
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
    _popupView.hidden = !_popupView.hidden;
}

#pragma mark - PopupViewDelegate

- (void)importButtonClicked {
    _popupView.hidden = YES;
    
    DLog(@"importButtonClicked");
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)settingButtonClicked {
    DLog(@"settingButtonClicked");
    _popupView.hidden = YES;
}

@end

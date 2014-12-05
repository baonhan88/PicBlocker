//
//  PhotoDetailViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "DatabaseHelper.h"

@interface PhotoDetailViewController ()

@property (strong, nonatomic) PopupView *popupView;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
    
    // add image full screen
    UIImage *image = [UIImage imageWithContentsOfFile:[Utils pathForImageWithName:_photoEntity.name]];

    _imageView = [[UIImageView alloc] initWithImage:image];
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
    
    DLog(@"number image was locked = %d", [[DatabaseHelper shareDatabase] numberPhotoLocked]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Common Methods

- (void)processLockImage {
    DLog(@"number image was locked = %d", [[DatabaseHelper shareDatabase] numberPhotoLocked]);
    if (![Utils isFullVersion] && [[DatabaseHelper shareDatabase] numberPhotoLocked]) {
        // show alert to let user buy full version
        DLog(@"show alert to let user buy full version");
    } else {
        [[DatabaseHelper shareDatabase] lockPhotoWithEntity:_photoEntity];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Events

- (void)cameraButtonClicked:(id)sender {
    DLog(@"cameraButtonClicked");
}

- (void)importSettingButtonClicked:(id)sender {
    DLog(@"importSettingButtonClicked");
    _popupView.hidden = !_popupView.hidden;
}

- (IBAction)deleteButtonClicked:(id)sender {
    // delete image in document folder
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    [fileManager removeItemAtPath:[Utils pathForImageWithName:_photoEntity.name] error:&error];
    
    if (error) {
        DLog(@"delete photo error with photo name = %@", _photoEntity.name);
    }
    
    // delete metadata in DB
    [[DatabaseHelper shareDatabase] deletePhotoWithEntity:_photoEntity];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)enlargeButtonClicked:(id)sender {
}

- (IBAction)shareButtonClicked:(id)sender {
//    NSString *textToShare = @"Look at this awesome website for aspiring iOS Developers!";
//    NSURL *myWebsite = [NSURL URLWithString:@"http://www.codingexplorer.com/"];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[Utils pathForImageWithName:_photoEntity.name]];
    NSArray *objectsToShare = @[image];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    
    NSArray *excludeActivities = @[UIActivityTypePostToFacebook,
                                   UIActivityTypePostToTwitter,
                                   UIActivityTypeMail
                                  ];
    
    activityVC.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)lockButtonClicked:(id)sender {
    // show input passcode popup
    
    // process lock image
    [self processLockImage];
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

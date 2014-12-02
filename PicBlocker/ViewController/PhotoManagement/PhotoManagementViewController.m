//
//  PhotoManagementViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "PhotoManagementViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoDetailViewController.h"

#define kNumberColumn       4

@interface PhotoManagementViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@property (strong, nonatomic) IBOutlet UIView *importSettingView;

@property (strong, nonatomic) NSMutableArray *photoList;

@end

@implementation PhotoManagementViewController

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
    
    // init photo list
    _photoList = [[NSMutableArray alloc] init];
    for (int i=0; i<50; i++) {
        NSString *imageName = @"screen_icon";
        [_photoList addObject:imageName];
    }
    
    // register photo cell
    UINib *cellNib = [UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil];

    [_photoCollectionView registerNib:cellNib
           forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (_photoList.count%kNumberColumn == 0) {
        return _photoList.count/kNumberColumn;
    }
    return (_photoList.count/kNumberColumn) + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_photoList.count/(section+1) < kNumberColumn) {
        return _photoList.count%kNumberColumn;
    }
    return kNumberColumn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell"
                                              forIndexPath:indexPath];
    
    
    return photoCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailViewController *photoDetailVC = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    [self.navigationController pushViewController:photoDetailVC animated:YES];
}

#pragma mark - Events

- (void)cameraButtonClicked:(id)sender {
    DLog(@"cameraButtonClicked");
}

- (void)importSettingButtonClicked:(id)sender {
    DLog(@"importSettingButtonClicked");
    _importSettingView.hidden = !_importSettingView.hidden;
}

- (IBAction)importButtonClicked:(id)sender {
    DLog(@"importButtonClicked");
}

- (IBAction)settingButtonClicked:(id)sender {
    DLog(@"settingButtonClicked");
}


@end

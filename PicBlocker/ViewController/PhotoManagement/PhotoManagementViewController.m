//
//  PhotoManagementViewController.m
//  PicBlocker
//
//  Created by NhanB on 12/4/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "PhotoManagementViewController.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoDetailViewController.h"
#import "PhotoEntity.h"
#import "DatabaseHelper.h"

#define kReusePhotoCollectionViewCell           @"PhotoCollectionViewCell"

@interface PhotoManagementViewController ()

//@property (strong, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@property (strong, nonatomic) PopupView *popupView;

@property (strong, nonatomic) NSMutableArray *photoList;
@property (assign, nonatomic) int numberColumn;

@end

@implementation PhotoManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
    
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
    
//    _photoList = [[NSMutableArray alloc] init];
//    [self loadFileFromDocumentFolder:@""];
//    _photoList = [[DatabaseHelper shareDatabase] getPhotoList];
    
    // register photo cell
    UINib *cellNib = [UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:cellNib
          forCellWithReuseIdentifier:kReusePhotoCollectionViewCell];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
    // reload data
    [self reloadPhotoData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Common Methods

- (void)saveImage:(UIImage *)image {
    // save image to document directory
    NSString *photoName = [Utils nameForImage];
    
    // Create paths to output images
    NSString  *jpgPath = [Utils pathForImageWithName:photoName];
    // Write a UIImage to JPEG with minimum compression (best quality)
    // The value 'image' must be a UIImage object
    // The value '1.0' represents image compression quality as value from 0.0 to 1.0
    [UIImageJPEGRepresentation(image, 0.8) writeToFile:jpgPath atomically:YES];
    
    // save metadata to userdefaults/SQLite DB
    PhotoEntity *entity = [[PhotoEntity alloc] init];
    entity.path = jpgPath;
    entity.name = photoName;
    entity.isLock = 0;
    [[DatabaseHelper shareDatabase] insertPhotoWithEntity:entity];
}

//- (void)loadFileFromDocumentFolder:(NSString *) filename {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,    NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory
//                                                                        error:NULL];
//    for (NSString *imageName in dirs) {
//        NSString *outputPath = [documentsDirectory stringByAppendingPathComponent:imageName];
//        PhotoEntity *entity = [[PhotoEntity alloc] init];
//        entity.path = outputPath;
//        [_photoList addObject:entity];
//    }
//    //    DLog(@"_photoList = %@", [_photoList description]);
//}

- (void)reloadPhotoData {
    _photoList = [[DatabaseHelper shareDatabase] getPhotoList];
    [self.collectionView reloadData];
    
//    for (PhotoEntity *entity in _photoList) {
//        DLog(@"photo name=%@ | path=%@ | islock = %d", entity.name, entity.path, entity.isLock);
//    }

}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    _numberColumn = [[UIScreen mainScreen] bounds].size.width > 320 ? 4 : 3;
    
    if (_photoList.count%_numberColumn == 0) {
        return _photoList.count/_numberColumn;
    }
    return (_photoList.count/_numberColumn) + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_photoList.count/(section+1) < _numberColumn) {
        return _photoList.count%_numberColumn;
    }
    return _numberColumn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    long index = indexPath.section * _numberColumn + indexPath.row;
    
    PhotoCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:kReusePhotoCollectionViewCell
                                                                                   forIndexPath:indexPath];
    
    PhotoEntity *entity = [_photoList objectAtIndex:index];
    photoCell.photoEntity = entity;
    [photoCell initCell];
    
    return photoCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    long index = indexPath.section * _numberColumn + indexPath.row;

    PhotoDetailViewController *photoDetailVC = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    photoDetailVC.photoEntity = [_photoList objectAtIndex:index];
    [self.navigationController pushViewController:photoDetailVC animated:YES];
}

#pragma mark - Events

- (void)cameraButtonClicked:(id)sender {
    DLog(@"cameraButtonClicked");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)importSettingButtonClicked:(id)sender {
    DLog(@"importSettingButtonClicked");
    _popupView.hidden = !_popupView.hidden;
}

#pragma mark - PopupViewDelegate

- (void)importButtonClicked {
    _popupView.hidden = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)settingButtonClicked {
    DLog(@"settingButtonClicked");
    _popupView.hidden = YES;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [self saveImage:image];
//    
//    // khong co tac dung
//    [self.collectionView reloadData];
//    
//    // You have the image. You can use this to present the image in the next view like you require in `#3`.
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    
    DLog(@"did finish picking image");
    [self saveImage:image];
    
    // reload data
    [self reloadPhotoData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

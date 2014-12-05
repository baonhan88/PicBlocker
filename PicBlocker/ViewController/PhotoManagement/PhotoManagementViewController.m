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

@interface PhotoManagementViewController ()

//@property (strong, nonatomic) IBOutlet UICollectionView *photoCollectionView;

@property (strong, nonatomic) PopupView *popupView;

@property (strong, nonatomic) NSMutableArray *photoList;

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
    _photoList = [[DatabaseHelper shareDatabase] getPhotoList];
    for (PhotoEntity *entity in _photoList) {
        DLog(@"photo name=%@ | path=%@ | islock = %d", entity.name, entity.path, entity.isLock);
    }
    
    // register photo cell
    UINib *cellNib = [UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil];
    
    [self.collectionView registerNib:cellNib
          forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
    
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Common Methods

- (void)saveImage:(UIImage *)image {
    // save image to document directory
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *docs = [paths objectAtIndex:0];
//    NSString *photoName = [Utils nameForImage];
//    NSString *path =  [docs stringByAppendingFormat:[NSString stringWithFormat:@"/%@.jpg", photoName]];
//    
//    NSData* imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, .8)];
//    NSError *writeError = nil;
//    
//    if(![imageData writeToFile:path options:NSDataWritingAtomic error:&writeError]) {
//        DLog(@"%@: Error saving image: %@", [self class], [writeError localizedDescription]);
//    }
    
    NSString *photoName = [Utils nameForImage];
    NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", photoName]]; //add our image to the path
    
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; //finally save the path (image)
    
//    NSLog(@"image saved");
    
    // save metadata to userdefaults/SQLite DB
    PhotoEntity *entity = [[PhotoEntity alloc] init];
    entity.path = fullPath;
    entity.name = photoName;
    entity.isLock = 0;
    [[DatabaseHelper shareDatabase] insertPhotoWithEntity:entity];
}

- (void)loadFileFromDocumentFolder:(NSString *) filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,    NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory
                                                                        error:NULL];
    for (NSString *imageName in dirs) {
        NSString *outputPath = [documentsDirectory stringByAppendingPathComponent:imageName];
        PhotoEntity *entity = [[PhotoEntity alloc] init];
        entity.path = outputPath;
        [_photoList addObject:entity];
    }
    //    DLog(@"_photoList = %@", [_photoList description]);
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    int numberColumn = [[UIScreen mainScreen] bounds].size.width > 320 ? 4 : 3;
    
    if (_photoList.count%numberColumn == 0) {
        return _photoList.count/numberColumn;
    }
    return (_photoList.count/numberColumn) + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    int numberColumn = [[UIScreen mainScreen] bounds].size.width > 320 ? 4 : 3;
    
    if (_photoList.count/(section+1) < numberColumn) {
        return _photoList.count%numberColumn;
    }
    return numberColumn;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell"
                                                                                   forIndexPath:indexPath];
    
    PhotoEntity *entity = [_photoList objectAtIndex:indexPath.row];
    photoCell.imageView.image = [UIImage imageWithContentsOfFile:entity.path];
    
    return photoCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailViewController *photoDetailVC = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
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
    
    // khong co tac dung
    [self.collectionView reloadData];
    
    // You have the image. You can use this to present the image in the next view like you require in `#3`.
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

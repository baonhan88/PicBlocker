//
//  PhotoCollectionViewCell.h
//  PicBlocker
//
//  Created by NhanB on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoEntity.h"

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) PhotoEntity *photoEntity;

- (void)initCell;

@end

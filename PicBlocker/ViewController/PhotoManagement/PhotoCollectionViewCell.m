//
//  PhotoCollectionViewCell.m
//  PicBlocker
//
//  Created by NhanB on 12/2/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)initCell {
    if (_photoEntity.isLock) {
        _imageView.image = [UIImage imageNamed:@"blocked_image"];
        
        UIImageView *lockImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image_lock_icon"]];
        lockImageView.frame = CGRectMake((self.frame.size.width - 24)/2, (self.frame.size.height-32)/2, 24, 32);
        [self addSubview:lockImageView];
        
        self.userInteractionEnabled = NO;
    } else {
        _imageView.image = [UIImage imageWithContentsOfFile:[Utils pathForImageWithName:_photoEntity.name]];
    }
    
}

@end

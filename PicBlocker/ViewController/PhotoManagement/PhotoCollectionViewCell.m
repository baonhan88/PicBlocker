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
        
        _lockImageView.hidden = NO;
        
        self.userInteractionEnabled = NO;
    } else {
        _imageView.image = [UIImage imageWithContentsOfFile:[Utils pathForImageWithName:_photoEntity.name]];
        
        _lockImageView.hidden = YES;
        
        self.userInteractionEnabled = YES;
    }
    
}

@end

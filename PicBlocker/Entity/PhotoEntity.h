//
//  PhotoEntity.h
//  PicBlocker
//
//  Created by NhanB on 12/3/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoEntity : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *path;
@property (assign, nonatomic) BOOL isLock;

@end

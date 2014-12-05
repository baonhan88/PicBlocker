//
//  DatabaseHelper.h
//  PicBlocker
//
//  Created by Nhan Bao on 12/05/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "PhotoEntity.h"

@interface DatabaseHelper : NSObject {
    FMDatabase  *database;
}

+ (DatabaseHelper *)shareDatabase;
- (BOOL)open;
- (BOOL)close;

- (NSMutableArray *)getPhotoList;
- (void)insertPhotoWithEntity:(PhotoEntity *)entity;
- (void)lockPhotoWithEntity:(PhotoEntity *)entity;
- (void)unlockPhotoWithEntity:(PhotoEntity *)entity;
- (int)numberPhotoLocked;
- (void)deletePhotoWithEntity:(PhotoEntity *)entity;

@end

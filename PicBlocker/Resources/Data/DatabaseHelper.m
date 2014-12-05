//
//  DatabaseHelper.m
//  PicBlocker
//
//  Created by Nhan Bao on 12/05/14.
//  Copyright (c) 2014 NhanB. All rights reserved.
//

#import "DatabaseHelper.h"
#import "FMDatabaseAdditions.h"

#define kDatabaseName               @"PicBlocker.sqlite"
#define kPhotoTableName             @"photo"

static DatabaseHelper *_shareDatabase = nil;

@implementation DatabaseHelper

+ (DatabaseHelper *)shareDatabase {
    @synchronized(self) {
        if (!_shareDatabase) {
            _shareDatabase = [[DatabaseHelper alloc] init];
        }
    }
    return _shareDatabase;
}

- (FMDatabase *)database {
    return database;
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *path = [self getDatabasePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path]) {
            NSString *originPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kDatabaseName];
            [fileManager copyItemAtPath:originPath toPath:path error:nil];
        }
        database = [[FMDatabase alloc] initWithPath:path];
    }
    return self;
}

- (NSString *)getDatabasePath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory , NSUserDomainMask, YES);
	NSString *cacheDir = [paths objectAtIndex:0];
	return [cacheDir stringByAppendingPathComponent:kDatabaseName];
}

- (BOOL)open {
    BOOL status = YES;
    if (![database open]) {
        NSLog(@"CAN'T OPEN DATABASE");
        status = NO;
    }
    return status;
}


- (BOOL)close {
    BOOL status = YES;
    if (![database close]) {
        NSLog(@"CAN'T CLOSE DATABASE");
        status = NO;
    }
    return status;
}

#pragma mark - TrainingEntity

// get photo list
- (NSMutableArray *)getPhotoList {
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@", kPhotoTableName];
    NSMutableArray *photoList = [[NSMutableArray alloc] init];
    if([self open]) {
        FMResultSet *result = [database executeQuery:query];
        
        while ([result next]) {
            PhotoEntity *entity = [[PhotoEntity alloc] init];
            entity.name = [result stringForColumn:@"name"];
            entity.path = [result stringForColumn:@"path"];
            entity.isLock = [result intForColumn:@"lock"];
            [photoList addObject:entity];
        }
        [self close];
    }
    return photoList;
}

- (void)insertPhotoWithEntity:(PhotoEntity *)entity {
    NSString *query = [NSString stringWithFormat:@"INSERT INTO %@ ('name','path','lock') VALUES ('%@','%@','%d')", kPhotoTableName, entity.name, entity.path, entity.isLock];
    if([self open]) {
        [database executeUpdate:query];
        [self close];
    }
}

- (void)lockPhotoWithEntity:(PhotoEntity *)entity {
    NSString *query = [NSString stringWithFormat:@"UPDATE %@ set lock = 1 WHERE name = '%@'", kPhotoTableName, entity.name];
    if([self open]) {
        [database executeUpdate:query];
        [self close];
    }
}

- (void)unlockPhotoWithEntity:(PhotoEntity *)entity {
    NSString *query = [NSString stringWithFormat:@"UPDATE %@ set lock = 0 WHERE name = '%@'", kPhotoTableName, entity.name];
    if([self open]) {
        [database executeUpdate:query];
        [self close];
    }
}

- (int)numberPhotoLocked {
//    int count = 0;
//    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@", kPhotoTableName];
//    if([self open]) {
//        FMResultSet *result = [database executeQuery:query];
//        
//        count = [result intForColumnIndex:1];
//        [self close];
//    }
    
    return [database intForQuery:@"SELECT COUNT(*) FROM %@", kPhotoTableName];
}

- (void)deletePhotoWithEntity:(PhotoEntity *)entity {
    NSString *query = [NSString stringWithFormat:@"DELETE FROM %@ WHERE name = '%@'", kPhotoTableName, entity.name];
    if([self open]) {
        [database executeUpdate:query];
        [self close];
    }
}

@end

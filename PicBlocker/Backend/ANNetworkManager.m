//
//  ANNetworkManager.m
//  Art Nature
//
//  Created by Hung Tran on 1/29/13.
//  Copyright (c) 2013 ® ARIS VIETNAM. All rights reserved.
//

#import "ANNetworkManager.h"

#define ANNETWORKMANAGER_HOST_API_NAME                      @"http://peerdevelopment.com/apps/picblock/api/"
#define ANNETWORKMANAGER_HOST_API_BASE_PATH                 @"ipadinfo/useripadinfo.foo?"
#define ANNETWORKMANAGER_HOST_API_USE_HTTPS                 YES

#define ANNETWORKMANAGER_HOST_API_FUNCTION_LOGIN            @"login"
#define ANNETWORKMANAGER_HOST_API_FUNCTION_REGISTER         @"register"

@implementation ANNetworkManager

- (id)initWithHostRequestAPI {
    self = [super initWithHostName:ANNETWORKMANAGER_HOST_API_NAME];
    if (self) {
        
    }
    
    return self;
}


#pragma mark - Support Method

- (NSDictionary *)dictionaryResultFromString:(NSString *)string {
    
    NSMutableDictionary *dictionaryResult = [NSMutableDictionary dictionary];
    if (string) {
        NSArray *stringsSeparatorByComma = [string componentsSeparatedByString:@","];
        NSArray *stringsSeparatorByEqual = nil;
        
        if (stringsSeparatorByComma && [stringsSeparatorByComma count] > 0) {
            for (NSString *stringTemp in stringsSeparatorByComma) {
                stringsSeparatorByEqual = [stringTemp componentsSeparatedByString:@"="];
                if (stringsSeparatorByEqual && [stringsSeparatorByEqual count] == 2) {
                    [dictionaryResult setObject:[stringsSeparatorByEqual objectAtIndex:1] forKey:[stringsSeparatorByEqual objectAtIndex:0]];
                }
            }
        }
    }
    
    if ([[dictionaryResult allKeys] count] > 0) {
        return dictionaryResult;
    }
    
    return nil;
}


#pragma mark - Request Server

- (MKNetworkOperation *)requestLoginWithUsername:(NSString *)username andPassword:(NSString *)password onCompletion:(void(^)(BOOL successful))completionBlock onError:(void (^)(NSString *errorMsg))errorHandler {
    //U@nCM : uppercase the password following the request at http://192.168.1.205:8000/issues/14675
    MKNetworkOperation *operation = [self operationWithPath:[NSString stringWithFormat:@"%@func=%@&usd=%@&pas=%@", ANNETWORKMANAGER_HOST_API_BASE_PATH, ANNETWORKMANAGER_HOST_API_FUNCTION_LOGIN, username, [password uppercaseString]] params:nil httpMethod:@"GET" ssl:ANNETWORKMANAGER_HOST_API_USE_HTTPS];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *resultString = completedOperation.responseString;
        
        NSDictionary *dictionary = [self dictionaryResultFromString:resultString];
        if (dictionary) {
            if ([[dictionary objectForKey:@"ret"] intValue] == 0) {
                // Set Division ID
//                [ANAppSettings setDivisionID:[NSString stringWithFormat:@"%@", [dictionary objectForKey:@"spd"]]];
                
                if (completionBlock) {
                    completionBlock(YES);
                }
            } else {
                if (completionBlock) {
                    completionBlock(NO);
                }
            }
        } else {
            if (completionBlock) {
                completionBlock(NO);
            }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (errorHandler) {
            errorHandler(error.description);
        }
    }];
    
    
    [self enqueueOperation:operation];
    
    return operation;
}

@end

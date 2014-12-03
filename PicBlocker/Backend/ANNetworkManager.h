//
//  ANNetworkManager.h
//  Art Nature
//
//  Created by Hung Tran on 1/29/13.
//  Copyright (c) 2013 ® ARIS VIETNAM. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface ANNetworkManager : MKNetworkEngine

- (id)initWithHostRequestAPI;

// Request login
- (MKNetworkOperation *)requestLoginWithUsername:(NSString *)username andPassword:(NSString *)password onCompletion:(void(^)(BOOL successful))completionBlock onError:(void (^)(NSString *errorMsg))errorHandler;

@end

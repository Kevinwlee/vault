//
//  CCBHTTPClient.h
//  CarbonBlack
//
//  Created by Kevin Lee on 9/23/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
/**
 The base URL for the Carbon API
 */
FOUNDATION_EXPORT NSString *const CarbonBaseURL;

/**
 The client should be used for all HTTP communication with the Carbon API.
 */
@interface CCBHTTPClient : AFHTTPSessionManager

/**
 @returns an singleton incstance of the network client.  This client should be use for all communication with the Carbon API.
 */
+ (CCBHTTPClient *)sharedClient;

@end

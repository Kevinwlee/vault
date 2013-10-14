//
//  CCBVaultProxy.h
//  CarbonBlack
//
//  Created by Kevin Lee on 10/8/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBHTTPClient.h"

@interface CCBVaultProxy : NSObject

+ (CCBVaultProxy *)sharedProxy;

- (void)createItem:(NSDictionary *)item
     inContainer:(NSString *)containerName
         success:(void(^)(id responseObject))success
         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)getItemsInContainer:(NSString *)containerName
                    success:(void(^)(id responseObject))success
                    failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)getItemWithId:(NSString *)vault_id inContainer:(NSString *)containerName
              success:(void(^)(id responseObject))success
              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)deleteItemWithId:(NSString *)vault_id inContainer:(NSString *)containerName
                 success:(void(^)(id responseObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)putItem:(NSDictionary *)item inContainer:(NSString *)containerName
        success:(void(^)(id responseObject))success
        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end

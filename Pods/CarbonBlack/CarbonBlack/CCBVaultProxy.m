//
//  CCBVaultProxy.m
//  CarbonBlack
//
//  Created by Kevin Lee on 10/8/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import "CCBVaultProxy.h"

@implementation CCBVaultProxy

+ (CCBVaultProxy *)sharedProxy {
    static CCBVaultProxy *__shared = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shared = [[CCBVaultProxy alloc] init];
    });
    return __shared;
}

- (void)createItem:(NSDictionary *)item
     inContainer:(NSString *)containerName
         success:(void(^)(id responseObject))success
         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {

    CCBHTTPClient *client = [CCBHTTPClient sharedClient];
    
    NSDictionary *paramData = @{@"data":item};
    NSString *path = [NSString stringWithFormat:@"vault/data/%@.json",containerName];
    [client POST:path parameters:paramData success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:failure];
}


- (void)getItemsInContainer:(NSString *)containerName
                    success:(void(^)(id responseObject))success
                    failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {

    CCBHTTPClient *client = [CCBHTTPClient sharedClient];
    NSString *path = [NSString stringWithFormat:@"vault/data/%@.json",containerName];
    [client GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:failure];
}


- (void)getItemWithId:(NSString *)vaultId inContainer:(NSString *)containerName
                    success:(void(^)(id responseObject))success
                    failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    CCBHTTPClient *client = [CCBHTTPClient sharedClient];
    NSString *path = [NSString stringWithFormat:@"vault/data/%@/%@",containerName, vaultId];
    [client GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:failure];
}

- (void)deleteItemWithId:(NSString *)vaultId inContainer:(NSString *)containerName
              success:(void(^)(id responseObject))success
              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSString *path = [NSString stringWithFormat:@"vault/data/%@/%@",containerName, vaultId];
    CCBHTTPClient *client = [CCBHTTPClient sharedClient];
    [client DELETE:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:failure];
}

- (void)putItem:(NSDictionary *)item inContainer:(NSString *)containerName
                 success:(void(^)(id responseObject))success
                 failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSDictionary *paramData = @{@"data":item};
    NSString *vault_id = [item objectForKey:@"id"];
    NSString *path = [NSString stringWithFormat:@"vault/data/%@/%@", containerName, vault_id];
    CCBHTTPClient *client = [CCBHTTPClient sharedClient];
    [client PUT:path parameters:paramData success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:failure];
}

@end

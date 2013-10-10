//
//  CCBVaultService.m
//  CarbonBlack
//
//  Created by Kevin Lee on 10/7/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import "CCBVaultService.h"

@implementation CCBVaultService

+ (CCBVaultService *)sharedService {
    static CCBVaultService *__shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shared = [[CCBVaultService alloc] init];
    });
    return __shared;
}


- (void)createItem:(NSDictionary *)item inContainer:(NSString *)containerName completion:(vaultCompletionBlock)completionBlock {
    if (!item) {
        [NSException raise:NSInvalidArgumentException format:@"Item cannot be nil"];
    }
    
    if (!containerName) {
        [NSException raise:NSInvalidArgumentException format:@"Container Name cannot be nil"];
    }
    
    
    [self.vaultProxy createItem:item inContainer:containerName success:^(id responseObject) {

        [self executeCompletionBlock:completionBlock withCarbonResponse:responseObject  error:nil];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
     
        [self executeCompletionBlock:completionBlock withCarbonResponse:nil error:error];
     
    }];
}

- (void)executeCompletionBlock:(vaultCompletionBlock)block withCarbonResponse:(NSDictionary *)carbonResponse error:(NSError *)error {
    if (block) {
        block(carbonResponse, error);
    }
}

- (void)getItem:(NSDictionary *)item completion:(vaultCompletionBlock)completionBlock {
    [NSException raise:@"Not Implemented" format:@"Not implemented."];
}

- (void)getItemsInContainerinContainer:(NSString *)containerName completion:(vaultListingCompletionBlock)completionBlock {
    [NSException raise:@"Not Implemented" format:@"Not implemented."];
}

- (void)getContainersWithCompletion:(vaultListingCompletionBlock)completionBlock {
    [NSException raise:@"Not Implemented" format:@"Not implemented."];
}

#pragma mark - overrides for injection

- (CCBVaultProxy *)vaultProxy {
    if (!_vaultProxy) {
        _vaultProxy = [CCBVaultProxy sharedProxy];
    }
    return _vaultProxy;
}

@end

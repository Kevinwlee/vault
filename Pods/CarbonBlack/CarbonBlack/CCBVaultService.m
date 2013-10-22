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

        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:responseObject  error:nil];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
     
        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:nil error:error];
     
    }];
}

- (void)createItem:(NSDictionary *)item withResources:(NSArray *) resources inContainer:(NSString *)containerName completion:(vaultCompletionBlock)completionBlock {
    if (!item) {
        [NSException raise:NSInvalidArgumentException format:@"Item cannot be nil"];
    }
    
    if (!containerName) {
        [NSException raise:NSInvalidArgumentException format:@"Container Name cannot be nil"];
    }
    
    
    
    [self.vaultProxy createItem:item withResources:resources inContainer:containerName success:^(id responseObject) {
        
        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:responseObject  error:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:nil error:error];
        
    }];
}


- (void)getItem:(NSDictionary *)item completion:(vaultCompletionBlock)completionBlock {
    
    NSString *vaultId = [item objectForKey:@"id"];
    if (!vaultId) {
        [NSException raise:NSInvalidArgumentException format:@"the item must have the vault id"];
    }

    NSString *container = [item objectForKey:@"container"];
    if (!container) {
        [NSException raise:NSInvalidArgumentException format:@"the item must have the container name"];
    }
    CCBVaultProxy *proxy = [self vaultProxy];
    [proxy getItemWithId:vaultId inContainer:container success:^(id responseObject) {
        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:responseObject error:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:nil error:error];
    }];
}

- (void)getItemsInContainerinContainer:(NSString *)containerName completion:(vaultListingCompletionBlock)completionBlock {

    if (!containerName) {
        [NSException raise:NSInvalidArgumentException format:@"Container name cannot be nil"];
    }
    
    CCBVaultProxy *proxy = [self vaultProxy];
    [proxy getItemsInContainer:containerName success:^(id responseObject) {
        completionBlock(responseObject, nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completionBlock (nil, error);
    }];

}

- (void)deleteItem:(NSDictionary *)item completion:(vaultCompletionBlock)completionBlock {
    
    NSString *vaultId = [item objectForKey:@"id"];
    if (!vaultId) {
        [NSException raise:NSInvalidArgumentException format:@"the item must have the vault id"];
    }
    
    NSString *container = [item objectForKey:@"container"];
    if (!container) {
        [NSException raise:NSInvalidArgumentException format:@"the item must have the container name"];
    }
    CCBVaultProxy *proxy = [self vaultProxy];
    [proxy deleteItemWithId:vaultId inContainer:container success:^(id responseObject) {
        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:responseObject error:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:nil error:error];
    }];
}

- (void)updateItem:(NSDictionary *)item completion:(vaultCompletionBlock)completionBlock {
    if (!item) {
        [NSException raise:NSInvalidArgumentException format:@"Item can't be nil"];
    }
    
    NSString *vaultId = [item objectForKey:@"id"];
    if (!vaultId) {
        [NSException raise:NSInvalidArgumentException format:@"the item must have the vault id"];
    }
    
    NSString *container = [item objectForKey:@"container"];
    if (!container) {
        [NSException raise:NSInvalidArgumentException format:@"the item must have the container name"];
    }
    
    CCBVaultProxy *proxy = [self vaultProxy];
    [proxy putItem:item inContainer:container success:^(id responseObject) {
        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:responseObject error:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self executeVaultCompletionBlock:completionBlock withCarbonResponse:nil error:error];
    }];
}

//- (void)getContainersWithCompletion:(vaultListingCompletionBlock)completionBlock {
//    [NSException raise:@"Not Implemented" format:@"Not implemented."];
//}

- (void)executeVaultCompletionBlock:(vaultCompletionBlock)block withCarbonResponse:(NSDictionary *)carbonResponse error:(NSError *)error {
    if (block) {
        block(carbonResponse, error);
    }
}

- (void)executeVaultListingCompletionBlock:(vaultListingCompletionBlock)block
                        withCarbonResponse:(NSArray *)carbonResponse
                                     error:(NSError *)error {
    if (block) {
        block(carbonResponse, error);
    }
}

#pragma mark - overrides for injection

- (CCBVaultProxy *)vaultProxy {
    if (!_vaultProxy) {
        _vaultProxy = [CCBVaultProxy sharedProxy];
    }
    return _vaultProxy;
}


@end

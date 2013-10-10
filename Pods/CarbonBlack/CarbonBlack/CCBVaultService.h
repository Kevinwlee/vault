//
//  CCBVaultService.h
//  CarbonBlack
//
//  Created by Kevin Lee on 10/7/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCBVaultProxy.h"

#define kCarbonVaultErrorDomain @"com.chaione.carbon.vault.error"

typedef NS_ENUM(NSInteger, CCBCarbonVaultErrorCode) { CCBMissingContainerCode };

typedef void (^vaultCompletionBlock)(NSDictionary *carbonResponse, NSError *error);
typedef void (^vaultListingCompletionBlock)(NSArray *carbonResponses, NSError *error);

@interface CCBVaultService : NSObject

/** 
 The vault proxy is used to proxy calls to the Carbon API
 */
@property (nonatomic, strong) CCBVaultProxy *vaultProxy;

/**
 The shared CCBVaultSerivce should be used to persist data to the Carbon Vault API.  This class provides methods for creating data in containers.  You can think of a container as a buck for common data.
 Once you persist data, you can retrieve it by id.  You can also retrieve all data in a specific container, and you can get a listing of all your containers.
 
 @returns the static shared instance of the the Vault Service
 */
+ (CCBVaultService *)sharedService;

/**
If you need to store data in the Carbon Vault, you will create the data in a container.
 @param item = the NSDictionary representation of the item you want to persist
 @param containerName is the name of the container that will be used to store similar data
 @param completionBlock is executed after the create operation has completed on the server.
 */
- (void)createItem:(NSDictionary *)item inContainer:(NSString *)containerName completion:(vaultCompletionBlock)completionBlock;

/** not implemented */
- (void)getItem:(NSDictionary *)item completion:(vaultCompletionBlock)completionBlock;

/** not implemented */
- (void)getItemsInContainerinContainer:(NSString *)containerName completion:(vaultListingCompletionBlock)completionBlock;

/** not implemented */
- (void)getContainersWithCompletion:(vaultListingCompletionBlock)completionBlock;

/** not implemented */
- (void)executeCompletionBlock:(vaultCompletionBlock)block withCarbonResponse:(NSDictionary *)carbonResponse error:(NSError *)error;


@end

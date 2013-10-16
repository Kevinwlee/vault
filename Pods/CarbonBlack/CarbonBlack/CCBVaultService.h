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
/** 
 Carbon Vault error codes.
 
 */
typedef NS_ENUM(NSInteger, CCBCarbonVaultErrorCode) { CCBMissingContainerCode };

typedef void (^vaultCompletionBlock)(NSDictionary *carbonResponse, NSError *error);
typedef void (^vaultListingCompletionBlock)(NSArray *carbonResponses, NSError *error);

/**
 The shared CCBVaultSerivce should be used to persist data to the Carbon Vault API.  This class provides methods for creating data in containers.
 You can think of a container as a bucket for common data.
 Once you persist data, you can retrieve it id.  You can also retrieve all data in a specific container.
 */
@interface CCBVaultService : NSObject

/** 
 The vault proxy that used to proxy calls to the Carbon API
 */
@property (nonatomic, strong) CCBVaultProxy *vaultProxy;

/**
 @returns the static shared instance of the the Vault Service
 */
+ (CCBVaultService *)sharedService;

/**
If you need to store data in the Carbon Vault, you will create the data in a container.
 @param item the NSDictionary representation of the item you want to persist
 @param containerName the name of the container that will be used to store similar data
 @param completionBlock executed after the create operation has completed on the server.
 */
- (void)createItem:(NSDictionary *)item inContainer:(NSString *)containerName completion:(vaultCompletionBlock)completionBlock;

/** 
Used to retrieve the latest version of an item that is stored in the Carbon Vault.
 @param item custom data item with vault id
 @param completionBlock executed when api request completes.
 */
- (void)getItem:(NSDictionary *)item completion:(vaultCompletionBlock)completionBlock;

/**
 Used to retrieve the latest version of an item that is stored in the Carbon Vault.
 @param containerName name of the container for the items
 @param completionBlock executed when the api request completes.
 */
- (void)getItemsInContainerinContainer:(NSString *)containerName completion:(vaultListingCompletionBlock)completionBlock;

///**
// Used to retrieve a list of all containers that are stored in the Carbon Vault.
// @param completionBlock excuted when api request completes.
// */
//- (void)getContainersWithCompletion:(vaultListingCompletionBlock)completionBlock;

/**
executes the vaultCompletionBlock passing in the dictionary and error.
 @param block a valut completeion block
 @param carbonResponse response dictionary from carbon vault api
 @param error NSError object.  can be nil.
 */
- (void)executeVaultCompletionBlock:(vaultCompletionBlock)block
            withCarbonResponse:(NSDictionary *)carbonResponse
                         error:(NSError *)error;

/**
 executes the vaultListingCompletionBlock passing in the dictionary and error.
 @param block a valut completeion block
 @param carbonResponse response dictionary from carbon vault api
 @param error NSError object.  can be nil.
 */
- (void)executeVaultListingCompletionBlock:(vaultListingCompletionBlock)block
                 withCarbonResponse:(NSDictionary *)carbonResponse
                              error:(NSError *)error;

@end

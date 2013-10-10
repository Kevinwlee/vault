//
//  CCBTokenRepository.h
//  CarbonBlack
//
//  Created by Kevin Lee on 9/24/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lockbox.h"

FOUNDATION_EXPORT NSString *const CarbonTokenKey;

/** 
 The Token repository is used to persist an authentication token in the Keychain.
 */
@interface CCBTokenRepository : NSObject

/**
 Returns a singleton instance of the token repository.
 @return a CCBTokenRepository
 */
+ (CCBTokenRepository *)sharedRepository;

/**
 Saves a the token to the keychain.
 @param token - the token to be persisted.
 */
- (void)saveToken:(NSString *)token;

/**
Use this method to verify that a valid token is available.
 */
- (BOOL)hasToken;

/**
 Used to access the token that has been persisted. 
 @return the token that is saved in the keychain.  The will return nil if the token doesn't exist.
 */
- (NSString *)token;

/**
 Use to delete the persisted access token.
 */
- (void)deleteToken;

@end

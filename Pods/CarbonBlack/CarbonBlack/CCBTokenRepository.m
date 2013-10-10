//
//  CCBTokenRepository.m
//  CarbonBlack
//
//  Created by Kevin Lee on 9/24/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import "CCBTokenRepository.h"

NSString *const CarbonTokenKey = @"carbon_token_key";

@implementation CCBTokenRepository

+ (CCBTokenRepository *)sharedRepository {
    static CCBTokenRepository *__shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shared = [[CCBTokenRepository alloc] init];
    });
    return __shared;
}

- (void)saveToken:(NSString *)token {
    [Lockbox setString:token forKey:CarbonTokenKey];
}

- (NSString *)token {
    return [Lockbox stringForKey:CarbonTokenKey];
}

- (BOOL)hasToken {
    NSString *token = [self token];
    return token != nil && ![token isEqual:[NSNull null]] && ![token isEqualToString:@""];
}

- (void)deleteToken {
    [Lockbox setString:nil forKey:CarbonTokenKey];
}

@end

//
//  CCBDefaultsRepository.m
//  CarbonBlack
//
//  Created by Kevin Lee on 9/24/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import "CCBDefaultsRepository.h"

NSString *const CarbonCompanyIdKey = @"carbon_company_id_key";

@implementation CCBDefaultsRepository

+ (CCBDefaultsRepository *)sharedRepository {
    static CCBDefaultsRepository *__shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shared = [[CCBDefaultsRepository alloc] init];
    });
    return __shared;
}

- (void)saveCompanyId:(NSString *)companyId {
    [[NSUserDefaults standardUserDefaults] setObject:companyId forKey:CarbonCompanyIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)companyId {
    return [[NSUserDefaults standardUserDefaults] valueForKey:CarbonCompanyIdKey];
}

- (BOOL)hasCompanyId {
    NSString *companyId = [self companyId];
    return companyId != nil && ![companyId isEqual:[NSNull null]] && ![companyId isEqualToString:@""];
}

@end

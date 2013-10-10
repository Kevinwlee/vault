//
//  CarbonBlack.m
//  CarbonBlack
//
//  Created by Travis Fischer on 9/18/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import "CarbonBlack.h"
#import  <UIKit/UIKit.h>

@interface CarbonBlack ()


+ (CarbonBlack *)sharedInstance;

@property (nonatomic, strong) NSString *devId;
@property (nonatomic, strong) NSString *appId;

@end

@implementation CarbonBlack

+ (CarbonBlack *)sharedInstance {
    static dispatch_once_t pred;
    static CarbonBlack *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[CarbonBlack alloc] init];
    });
    return shared;
}

+ (void)registerWithClientId:(NSString *)clientId andAppId:(NSString *)appId {
    
    if (!clientId) {
        [NSException raise:NSInvalidArgumentException format:@"Client ID cannot be nil"];
    }
    
    if (!appId) {
        [NSException raise:NSInvalidArgumentException format:@"App ID cannot be nil"];
    }
    
    [CarbonBlack sharedInstance].devId = clientId;
    [CarbonBlack sharedInstance].appId = appId;
}

/**
 * The developer ID registered with Carbon
 */
+ (NSString *)clientId {
    return [CarbonBlack sharedInstance].devId;
}

/**
 * The application's ID registered with Carbon
 */
+ (NSString *)applicationId {
    return [CarbonBlack sharedInstance].appId;
}

+ (NSString *)deviceId {
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}

@end

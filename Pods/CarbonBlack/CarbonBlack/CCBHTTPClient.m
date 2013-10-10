//
//  CBHTTPClient.m
//  CarbonBlack
//
//  Created by Kevin Lee on 9/23/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import "CCBHTTPClient.h"
#import "CCBTokenRepository.h"
#import "CarbonBlack.h"

NSString *const CarbonBaseURL = @"http://carbon-staging.herokuapp.com/api/v1/";

//NSString *const Carbon

@implementation CCBHTTPClient

+ (CCBHTTPClient *)sharedClient {
    static CCBHTTPClient *__sharedClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSMutableDictionary *headers = [NSMutableDictionary dictionary];
        
        if (![CarbonBlack clientId]) {
            [NSException raise:NSInvalidArgumentException format:@"Client ID has not been set."];
        }
        
        [headers setObject:[CarbonBlack clientId] forKey:@"CARBON_CLIENT_ID"];
        
        if (![CarbonBlack applicationId]) {
            [NSException raise:NSInvalidArgumentException format:@"Application ID has not been set."];
        }
        
        [headers setObject:[CarbonBlack applicationId] forKey:@"CARBON_APP_ID"];
        
        
        if (![CarbonBlack deviceId]) {
            [NSException raise:NSInvalidArgumentException format:@"Device ID has not been set."];
        }
        
        [headers setObject:[CarbonBlack deviceId] forKey:@"CARBON_DEVICE_ID"];

        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        [headers setObject:@"application/json" forKey:@"Content-Type"];
        [headers setObject:@"application/json" forKey:@"Accept"];
        
        [config setHTTPAdditionalHeaders:headers];
        
        __sharedClient = [[CCBHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:CarbonBaseURL] sessionConfiguration:config];
    });
    
    return __sharedClient;
}
@end

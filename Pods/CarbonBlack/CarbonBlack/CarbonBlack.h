//
//  CarbonBlack.h
//  CarbonBlack
//
//  Created by Travis Fischer on 9/18/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The primary interface with the Carbon Black SDK
 */
@interface CarbonBlack : NSObject

/**
 * Registers the app with Carbon. Call should be made on app launch.
 * @param clientId The developer's Carbon ID
 * @param appId The application's ID in the Carbon system.
 */
+ (void)registerWithClientId:(NSString *)clientId andAppId:(NSString *)appId;


/**
 * The developer ID registered with Carbon
 */
+ (NSString *)clientId;

/**
 * The application's ID registered with Carbon
 */
+ (NSString *)applicationId;

/**
 * The ID for the device
 */
+ (NSString *)deviceId;

@end

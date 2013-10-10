//
//  CCBDefaultsRepository.h
//  CarbonBlack
//
//  Created by Kevin Lee on 9/24/13.
//  Copyright (c) 2013 ChaiOne. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const CarbonCompanyIdKey;
/**
The defaults repository should be used to store information to the NSUserDefaults.
 */
@interface CCBDefaultsRepository : NSObject

/**
returns a singleton instance of the CCBDefaultsRepository
 @returns CCBDefaults - singleton instance.
 */
+ (CCBDefaultsRepository *)sharedRepository;

/**
 Use save company id to perist the company id to user defaults.
 This method uses NSUserDefaults to persist the string, and calls syncronize on NSUserDefaults.
 @param companyId - is epxected to be a non empty NSString.
 */
- (void)saveCompanyId:(NSString *)companyId;

/**
Use this mehtod to retrieve the company_id from the repository.
 @returns the company id that was saved.  This method will return nil of the company id does not exist.
 */
- (NSString *)companyId;

/**
Use this method To determine if a valid compnay id exists.  
 @return YES if a non nil, non NSNull, non empty string exists.
 */
- (BOOL)hasCompanyId;
@end

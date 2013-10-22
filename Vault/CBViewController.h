//
//  CBViewController.h
//  Vault
//
//  Created by Kevin Lee on 10/9/13.
//  Copyright (c) 2013 ChaiONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBVaultService.h"

@interface CBViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addPhotoTapped;

@end

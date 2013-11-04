//
//  CBViewController.m
//  Vault
//
//  Created by Kevin Lee on 10/9/13.
//  Copyright (c) 2013 ChaiONE. All rights reserved.
//

#import "CBViewController.h"

@interface CBViewController ()

@end

@implementation CBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPhotoTapped:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType =
    UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = NO;
    
    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *resource = UIImageJPEGRepresentation(image, .01);
    CCBVaultResource *vaultResource = [[CCBVaultResource alloc] initWithName:@"picture" fileName:@"picture.jpg" mimeType:@"image/jpeg" data:resource];
    
    CCBVaultService *svc = [CCBVaultService sharedService];
    NSDictionary *otherData = @{@"name":@"kevin", @"email":@"kevin@chaione.com", @"children":@[@"warren", @"kyle"]};
    
    [svc createItem:otherData withResources:@[vaultResource] inContainer:@"profile" completion:^(NSDictionary *carbonResponse, NSError *error) {
        if (error) {
            NSLog(@"ERROR: %@", error);
        } else {
            NSLog(@"SUCCESS: %@", carbonResponse);
        }
    }];
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
}

@end

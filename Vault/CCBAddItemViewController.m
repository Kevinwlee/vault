//
//  CCBAddItemViewController.m
//  Vault
//
//  Created by Kevin Lee on 10/9/13.
//  Copyright (c) 2013 ChaiONE. All rights reserved.
//

#import "CCBAddItemViewController.h"

@interface CCBAddItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *itemTextField;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;

@end

@implementation CCBAddItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveTapped:(id)sender {
    NSString *item = self.itemTextField.text;
    NSString *count = self.countTextField.text;
    
    CCBVaultService *svc = [CCBVaultService sharedService];
    
    NSDictionary *data = @{@"item":item, @"count":count};
    
    [svc createItem:data inContainer:@"inventory" completion:^(NSDictionary *carbonResponse, NSError *error) {
        if (error) {
            NSLog(@"Item was not created");
            return;
        } else {
            NSLog(@"Item added");
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    
}

@end

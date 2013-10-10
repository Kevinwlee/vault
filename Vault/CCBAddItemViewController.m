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
    
    CCBVaultProxy *proxy = [CCBVaultProxy sharedProxy];
    
    NSDictionary *data = @{@"item":item, @"count":count};
    
    [proxy createItem:data inContainer:@"inventory" success:^(id responseObject) {
        NSLog(@"responseObject %@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"That didn't work! :(");
    }];
}

@end

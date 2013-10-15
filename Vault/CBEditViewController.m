//
//  CBEditViewController.m
//  Vault
//
//  Created by Kevin Lee on 10/14/13.
//  Copyright (c) 2013 ChaiONE. All rights reserved.
//

#import "CBEditViewController.h"

@interface CBEditViewController ()
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextField *itemTextField;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;

@end

@implementation CBEditViewController

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

- (void)viewWillAppear:(BOOL)animated {
    self.itemTextField.text = [self.item valueForKeyPath:@"custom_data.item"];
    self.countTextField.text = [self.item valueForKeyPath:@"custom_data.count"];
    self.idLabel.text = [[self.item objectForKey:@"id"] stringValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTapped:(id)sender {
    
    NSMutableDictionary *edit = [NSMutableDictionary dictionaryWithDictionary:self.item];

    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[edit objectForKey:@"custom_data"]];
    [data setValue:self.itemTextField.text forKeyPath:@"item"];
    [data setValue:self.countTextField.text forKeyPath:@"count"];
    [edit setObject:data forKey:@"custom_data"];
    NSLog(@"Item %@", edit);
    CCBVaultProxy *proxy = [CCBVaultProxy sharedProxy];
    [proxy putItem:edit inContainer:@"inventory" success:^(id responseObject) {
      [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failed %@", error);
    }];

}

@end

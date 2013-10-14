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
    [self.navigationController popViewControllerAnimated:YES];
}

@end

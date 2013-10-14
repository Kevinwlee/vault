//
//  CBTableViewController.m
//  Vault
//
//  Created by Kevin Lee on 10/14/13.
//  Copyright (c) 2013 ChaiONE. All rights reserved.
//

#import "CBTableViewController.h"

@interface CBTableViewController ()
@property (nonatomic, strong) NSArray *items;
@end

@implementation CBTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self refresh];
}

- (void)refresh {
    CCBVaultProxy *proxy = [CCBVaultProxy sharedProxy];
    [proxy getItemsInContainer:@"inventory" success:^(id responseObject) {
        self.items = responseObject;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error %@", error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)itemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.items objectAtIndex:indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ItemCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *item = [self itemAtIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@", [item objectForKey:@"id"], [item valueForKeyPath:@"custom_data.item"],[item valueForKeyPath:@"custom_data.count"]];
    return cell;
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end

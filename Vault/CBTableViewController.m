//
//  CBTableViewController.m
//  Vault
//
//  Created by Kevin Lee on 10/14/13.
//  Copyright (c) 2013 ChaiONE. All rights reserved.
//

#import "CBTableViewController.h"

@interface CBTableViewController ()
@property (nonatomic, strong) NSMutableArray *items;
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
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)refresh {
    CCBVaultProxy *proxy = [CCBVaultProxy sharedProxy];
    [proxy getItemsInContainer:@"inventory" success:^(id responseObject) {
        self.items = [NSMutableArray arrayWithArray:responseObject];
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

- (void)deleteItem:(NSDictionary *)item {
    CCBVaultProxy *proxy = [CCBVaultProxy sharedProxy];
    NSString *vault_id = [item objectForKey:@"id"];
    NSLog(@"id %@", vault_id);
    [proxy deleteItemWithId:vault_id inContainer:@"inventory" success:^(id responseObject) {
        NSLog(@"Deleted");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Delete FAILED");
    }];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete: {
            NSDictionary *i = [self itemAtIndexPath:indexPath];
            [self deleteItem:i];
            [self.items removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            NSLog(@"Delete the row");
        }
            break;
        default:
            break;
    }
    
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSDictionary *selectedItem = [self itemAtIndexPath:[self.tableView indexPathForSelectedRow]];
    CBEditViewController *vc = (CBEditViewController*)segue.destinationViewController;
    vc.item = selectedItem;
}



@end

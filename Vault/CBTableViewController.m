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
    CCBVaultService *svc = [CCBVaultService sharedService];
    [svc getItemsInContainerinContainer:@"inventory" completion:^(NSArray *carbonResponses, NSError *error) {
        if (error) {
            NSLog(@"error getting items");
        } else {
            self.items = [NSMutableArray arrayWithArray:carbonResponses];
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSDictionary *)itemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.items objectAtIndex:indexPath.row];
}

- (void)deleteItem:(NSDictionary *)item {
    CCBVaultService *svc = [CCBVaultService sharedService];
    [svc deleteItem:item completion:^(NSDictionary *carbonResponse, NSError *error) {
        if (error) {
            NSLog(@"error deleting item");
        } else {
            NSLog(@"deleted");
        }
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

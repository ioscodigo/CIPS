//
//  ChipsExampleTableViewController.m
//  Chips_Example
//
//  Created by Fajar on 4/26/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "ChipsExampleTableViewController.h"

@interface ChipsExampleTableViewController ()

@end

@implementation ChipsExampleTableViewController
NSArray *items;
- (void)viewDidLoad {
    [super viewDidLoad];
    items = @[@"Hearsay",@"Spotlight",@"Squad",@"Qnock"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = items[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *segue = [NSString stringWithFormat:@"%@Start",[items[indexPath.row] lowercaseString]];
    [self performSegueWithIdentifier:segue sender:self];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

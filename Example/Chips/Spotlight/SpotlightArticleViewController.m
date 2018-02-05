//
//  SpotlightArticleViewController.m
//  Chips_Example
//
//  Created by Fajar on 1/25/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightArticleViewController.h"
#import "SpotlightArticleListViewController.h"

@interface SpotlightArticleViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SpotlightArticleViewController

NSArray *nameList;
//NSArray *vcList;

- (void)viewDidLoad {
    [super viewDidLoad];
    nameList = @[@"Article List",@"Article List by Channel",@"Article List Standard",@"Article List Standard by Channel",@"Article List Gallery",@"Article List Gallery by Channel",@"Article List Group",@"Article List Group by Channel",@"Article List Arround Me"];
    [_tableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return nameList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)cell.contentView.subviews[0];
    label.text = nameList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpotlightArticleListViewController *vc = (SpotlightArticleListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"spotlightArticleListVC"];
    vc.type = indexPath.row;
    [self.navigationController pushViewController:vc animated:true];
}

@end

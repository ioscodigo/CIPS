//
//  SpotlightHomepageViewController.m
//  Chips_Example
//
//  Created by Fajar on 1/29/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightHomepageViewController.h"
#import "SpotlightHomepageListViewController.h"
#import "SpotlightSupport.h"

@interface SpotlightHomepageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SpotlightHomepageViewController

NSArray *nameList;

- (void)viewDidLoad {
    [super viewDidLoad];
    nameList = @[@"Homepage Headline",@"Homepage Story",@"Homepage Editor Choice",@"Homepage Newsboost",@"Homepage Commercial",@"Homepage Boxtype"];
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
    SpotlightHomepageListViewController *vc = (SpotlightHomepageListViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"spotlightHomepageListVC"];
    vc.type = indexPath.row;
    vc.channel = SpotlightSupport.service.channelNo;
//    vc.channel = @"CHANNEL00917";
    [self.navigationController pushViewController:vc animated:true];
}


@end

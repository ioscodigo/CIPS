//
//  SpotlightSearchViewController.m
//  Chips_Example
//
//  Created by Fajar on 2/9/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightSearchViewController.h"
#import "SpotlightArticleDetailViewController.h"
#import <Cips/Cips.h>

@interface SpotlightSearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SpotlightSearchViewController
NSArray *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    data = @[];
    [self.tableView reloadData];
    _searchBar.delegate = self;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [Spotlight.instance spotlightArticleSearchWithKeyword:searchText withLimit:10 withUserId:@"guest" onComplete:^(SpotlightResponseModel *response) {
//        data = @[]
        if ([response.status isEqualToString:@"200"]){
            data = @[response.data];
            [_tableView reloadData];
        }else{
            data = @[];
            [_tableView reloadData];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *item = data[indexPath.row];
    UILabel *articletitle = [(UILabel *)cell.contentView.subviews[0] viewWithTag:1];
    UILabel *articledesc = [(UILabel *)cell.contentView.subviews[0] viewWithTag:2];
    UILabel *articlecreator = [(UILabel *)cell.contentView.subviews[0] viewWithTag:3];
    articletitle.text = [item objectForKey:@"_title"];
    articledesc.text = [item objectForKey:@"_desc"];
    articlecreator.text = [item objectForKey:@"editor"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = data[indexPath.row];
    SpotlightArticleDetailViewController *vc = (SpotlightArticleDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"spotlightArticleDetailVC"];
    vc.article_id = [item valueForKey:@"_slug_unique_number"];
    [self.navigationController pushViewController:vc animated:true];
}

@end

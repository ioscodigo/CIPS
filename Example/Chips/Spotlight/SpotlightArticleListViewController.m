//
//  SpotlightArticleListViewController.m
//  Chips_Example
//
//  Created by Fajar on 1/25/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightArticleListViewController.h"
#import "SpotlightArticleDetailViewController.h"
#import <Cips/Cips.h>
#import "SpotlightSupport.h"

@interface SpotlightArticleListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SpotlightArticleListViewController

NSArray *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    data = @[];
    [_tableView reloadData];
    Spotlight *instance = Spotlight.instance;
    switch (_type) {
        case 0:
        {
            [instance spotlightArticleWithWithUserId:@"guset" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                [self responseList:response];
            }];
            break;
        }
        case 1:
        {
            [instance spotlightArticleWithChannel:[SpotlightSupport.service channelNo] withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                [self responseList:response];
            }];
            break;
        }
        case 2:
        {
            [instance spotlightArticleStandardWithUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                [self responseList:response];
            }];
            break;
        }
        case 3:
        {
            [instance spotlightArticleStandardWithChannel:[SpotlightSupport.service channelNo] withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                [self responseList:response];
            }];
            break;
        }
        case 4:
        {
            [instance spotlightArticleGalleryWithUserId:@"guest" withPage:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                [self responseList:response];
            }];
            break;
        }
        case 5:
        {
            [instance spotlightArticleGalleryWithChannel:[SpotlightSupport.service channelNo] withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                [self responseList:response];
            }];
            break;
        }
        case 6:
        {
            [instance spotlightArticleGroupWithUserId:@"guest" withPage:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                [self responseList:response];
            }];
            break;
        }
        case 7:
        {
            [instance spotlightArticleGroupWithChannel:@"CHANNEL00817" withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                [self responseList:response];
            }];
            break;
        }
        case 8:
        {
            [instance spotlightArticleAroundMeWithLatitude:@"-6.1700972" longitude:@"106.827665" radius:@"10" withUserId:@"guest" page:0 limit:10 onComplete:^(SpotlightResponseModel *response) {
                [self responseList:response];
            }];
            break;
        }
        default:
            break;
    }
    
}

-(void)responseList:(SpotlightResponseModel *)response{
    if([response.status isEqualToString:@"200"]){
        data = [response.data objectForKey:@"list"];
        [_tableView reloadData];
    }else{
        [SpotlightSupport showMessage:@"error" msg:response.display_message vc:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

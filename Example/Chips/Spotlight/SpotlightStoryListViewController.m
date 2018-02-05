//
//  SpotlightStoryListViewController.m
//  Chips
//
//  Created by Fajar on 1/23/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightStoryListViewController.h"
#import "SpotlightStoryDetailViewController.h"
#import "SpotlightSupport.h"

@interface SpotlightStoryListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *storytableView;

@end

@implementation SpotlightStoryListViewController

NSArray *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = @[];
    [_storytableView reloadData];
    // Do any additional setup after loading the view.
    
    if(!_isChannel){
        [Spotlight.instance spotlightStoryListWithUserid:@"guest" page:0 limit:10 limitArticle:@"10" onComplete:^(SpotlightResponseModel *response) {
//            NSLog(@"respon %@",response.data);
            if([response.status isEqualToString:@"200"]){
                data = [response.data valueForKey:@"list"];
                [_storytableView reloadData];
            }else{
                [SpotlightSupport showMessage:@"error" msg:response.display_message vc:self];
            }
        }];
    }else{
        [Spotlight.instance spotlightStoryListWithChannel:@"CHANNEL00217" withUserId:@"guest" page:0 limit:10 limitArticle:@"10" onComplete:^(SpotlightResponseModel *response) {
//            NSLog(@"respon %@",response.data);
            if([response.status isEqualToString:@"200"]){
                data = [response.data valueForKey:@"list"];
                [_storytableView reloadData];
            }else{
                [SpotlightSupport showMessage:@"error" msg:response.display_message vc:self];
            }
        }];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *item = data[indexPath.row];
    UIView *contentView = cell.contentView;
    UILabel *labelNo = (UILabel *)[contentView viewWithTag:1];
    UILabel *name = (UILabel *)[contentView viewWithTag:2];
    UILabel *article = (UILabel *)[contentView viewWithTag:3];
    
    labelNo.text = [item valueForKey:@"story_no"];
    name.text = [item valueForKey:@"_name"];
    NSLog(@"log %@",[item valueForKey:@"article"]);
    article.text = [NSString stringWithFormat:@"%@",[[item valueForKey:@"article"] valueForKey:@"totalRows"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = data[indexPath.row];
    
    SpotlightStoryDetailViewController *vc = (SpotlightStoryDetailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"spotlightStoryDetailVC"];
    vc.story_no = [item valueForKey:@"_slug_unique_number"];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backOnCliick:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


@end

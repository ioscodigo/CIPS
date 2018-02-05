//
//  SpotlightLiveStreamingViewController.m
//  Chips_Example
//
//  Created by Fajar on 1/28/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightLiveStreamingViewController.h"
#import <Cips/Cips.h>
#import "SpotlightSupport.h"

@interface SpotlightLiveStreamingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SpotlightLiveStreamingViewController

NSArray *data;
- (void)viewDidLoad {
    [super viewDidLoad];
    [Spotlight.instance spotlightLiveStreamingWithChannel:[SpotlightSupport service].channelNo withUserId:@"guest" onComplete:^(SpotlightResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            data = response.data;
            [_tableView reloadData];
            [SpotlightSupport showMessage:@"Success" msg:response.display_message vc:self];
        }else{
            [SpotlightSupport showMessage:@"error" msg:response.display_message vc:self];
        }
    }];
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
    articletitle.text = [item objectForKey:@"live_streaming_no"];
    articledesc.text = [item objectForKey:@"_title"];
    articlecreator.text = [item objectForKey:@"_desc"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item = data[indexPath.row];
    [Spotlight.instance spotlightLiveStreamingShareWithStreamingId:[item objectForKey:@"live_streaming_no"] userid:@"guest" shareType:@"2" fromEmail:@"test@mailhog.codigo.id" toEmail:@"test2@mailhog.codigo.id" message:@"msg" onComplete:^(SpotlightResponseModel *response) {
        [SpotlightSupport showMessage:@"status" msg:response.display_message vc:self];
    }];
}



@end

//
//  SpotlightChannelListViewController.m
//  Chips
//
//  Created by Fajar on 1/22/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightChannelListViewController.h"
#import "SpotlightTestingViewController.h"
#import "SpotlightSupport.h"


@interface SpotlightChannelListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SpotlightChannelListViewController
NSArray *data;
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.estimatedRowHeight = 72;
    _tableView.rowHeight = UITableViewAutomaticDimension;
//    _tableView.
    [Spotlight.instance spotlightChannelListWithUserId:@"guset" onComplete:^(SpotlightResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            data = [response.data valueForKey:@"result"];
            NSLog(@"%@",data);
            [_tableView reloadData];
        }
    }];
    // Do any additional setup after loading the view.
//    [Spotlight.instance ]
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count %ld",data.count);
    return data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *article_no = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *article_name = (UILabel *)[cell.contentView viewWithTag:2];
    NSDictionary *item = data[indexPath.row];
//    NSLog(@"%@",item);
    article_no.text = [item objectForKey:@"channel_no"];
    article_name.text = [item objectForKey:@"_name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    channelSelected = true;
    channelName = [data[indexPath.row] objectForKey:@"channel_no"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Channel" message:@"Channel selected." preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dissmis" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:true completion:nil];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backOnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end

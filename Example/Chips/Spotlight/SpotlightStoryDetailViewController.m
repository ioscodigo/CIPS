//
//  SpotlightStoryDetailViewController.m
//  Chips_Example
//
//  Created by Fajar on 1/25/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightStoryDetailViewController.h"
#import "SpotlightSupport.h"

@interface SpotlightStoryDetailViewController ()

@end

@implementation SpotlightStoryDetailViewController

NSArray *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Spotlight.instance spotlightStoryDetailWithStoryNo:_story_no withUserId:@"guest" limitArticle:10 onComplete:^(SpotlightResponseModel *response) {
        NSLog(@"%@",response.status);
        if([response.status isEqualToString:@"200"]){
            NSLog(@"response %@",response.data);
            data = [[response.data objectForKey:@"article"] objectForKey:@"list"];
            _storyno.text = [response.data objectForKey:@"story_no"];
            _storyName.text = [response.data objectForKey:@"_name"];
            _storyArticle.text = [NSString stringWithFormat:@"%ld",(long)[[response.data objectForKey:@"article"] objectForKey:@"totalRows"]];
            [_tableView reloadData];
        }else{
            [SpotlightSupport showMessage:@"Error" msg:response.display_message vc:self];
        }
    }];
//    _storyno.text = _story_no;
}
- (IBAction)backOnClick:(id)sender {
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *item = data[indexPath.row];
    UILabel *articletitle = [(UILabel *)cell.contentView.subviews[0] viewWithTag:1];
    UILabel *articledesc = [(UILabel *)cell.contentView.subviews[0] viewWithTag:2];
    UILabel *articlecreator = [(UILabel *)cell.contentView.subviews[0] viewWithTag:3];
    articletitle.text = [item objectForKey:@"_meta_title"];
    articledesc.text = [item objectForKey:@"_meta_desc"];
    articlecreator.text = [item objectForKey:@"editor"];
    return cell;
}
- (IBAction)shareOnClick:(id)sender {
    [Spotlight.instance spotlightStoryShareWithStoryNo:_storyno.text withUserId:@"guest" type:@"2" fromEmail:@"test@mailhog.codigo.id" toEmail:@"test2@mailhog.codigo.id" message:@"test story" onComplete:^(SpotlightResponseModel *response) {
        NSLog(@"data %@",response.data);
        [SpotlightSupport showMessage:@"status" msg:response.display_message vc:self];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}

@end

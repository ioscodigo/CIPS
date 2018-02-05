//
//  SpotlightArticleDetailViewController.m
//  Chips_Example
//
//  Created by Fajar on 1/25/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightArticleDetailViewController.h"
#import <Cips/Cips.h>
#import "SpotlightSupport.h"

@interface SpotlightArticleDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelContetn;
@property (weak, nonatomic) IBOutlet UILabel *labelLocation;
@property (weak, nonatomic) IBOutlet UILabel *labelEditor;
@property (weak, nonatomic) IBOutlet UITableView *tableReaction;

@end

@implementation SpotlightArticleDetailViewController
NSArray *dataReaction;
NSString *article_no;
- (void)viewDidLoad {
    article_no = @"";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Spotlight.instance spotlightArticleDetailWithId:_article_id withUserId:@"guest" onComplete:^(SpotlightResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            article_no = [response.data valueForKey:@"article_no"];
            [Spotlight.instance spotlightReactionListWithArticleId:article_no withUserId:@"guest" onComplete:^(SpotlightResponseModel *respon) {
                if([respon.status isEqualToString:@"200"]){
//                    NSLog(@"reaction data %@",respon.data);
                    dataReaction = respon.data;
                    [_tableReaction reloadData];
                }else{
                    [SpotlightSupport showMessage:@"error" msg:respon.display_message vc:self];
                }
            }];
            article_no = [response.data valueForKey:@"article_no"];
            _labelName.text = [response.data valueForKey:@"_title"];
            _labelDescription.text = [response.data valueForKey:@"_desc"];
            _labelContetn.text = [response.data valueForKey:@"_content"];
            _labelEditor.text = [response.data valueForKey:@"editor"];
            _labelLocation.text = [response.data valueForKey:@"location_name"];
        }else{
            [SpotlightSupport showMessage:@"error" msg:response.display_message vc:self];
        }
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataReaction.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *item = dataReaction[indexPath.row];
    UILabel *reactionName = [(UILabel *)cell.contentView.subviews[0] viewWithTag:1];
    UILabel *reactionTotal = [(UILabel *)cell.contentView.subviews[0] viewWithTag:2];
    reactionName.text = [item objectForKey:@"_name"];
    reactionTotal.text = [NSString stringWithFormat:@"%d",(int)[item objectForKey:@"totalreaction"]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)shareOnClick:(id)sender {
    [Spotlight.instance spotlightArticleShareWithArticleNo:article_no withUserId:@"guset" type:@"2" fromEmail:@"abc@codigo.id" toEmail:@"ddd@codigo.id" message:@"test" onComplete:^(SpotlightResponseModel *response) {
        [SpotlightSupport showMessage:@"status" msg:response.display_message vc:self];
    }];
}
- (IBAction)submitReaction:(id)sender {
    [Spotlight.instance spotlightReactionSubmitWithArticleId:article_no withReactionNo:@"2" withUserId:@"guest" onComplete:^(SpotlightResponseModel *response) {
        [SpotlightSupport showMessage:@"status" msg:response.display_message vc:self];
    }];
}

@end

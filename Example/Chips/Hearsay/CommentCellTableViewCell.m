//
//  CommentCellTableViewCell.m
//  Chips_Example
//
//  Created by Fajar on 4/6/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "CommentCellTableViewCell.h"
#import "HearsayReplyCommentTableViewCell.h"
#import <Cips/Cips.h>
#import <Cips/SquadViewHelper.h>
#import <DateTools/DateTools.h>

@interface CommentCellTableViewCell()<UITableViewDelegate,UITableViewDataSource,HearsayReplyCommentDelegate>

@end

@implementation CommentCellTableViewCell

SquadViewHelper *helper;

- (void)awakeFromNib {
    [super awakeFromNib];
    helper = [SquadViewHelper helper];
    self.isReplay = false;
    // Initialization code
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HearsayReplyCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"replayCell"];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    [self initiateObserver];
}

-(void)initiateObserver{
    if(self.childItems.count > 0){
//    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    }
}

-(void)removeObserverTableView{
    if(self.childItems.count > 0){
//        [self.tableView removeObserver:self forKeyPath:@"contentSize"];
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentSize"]){
        CGFloat height = [[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue].height;
        NSLog(@"height2 %f,%f",self.constraintTableViewHeight.constant,height);
        if(self.constraintTableViewHeight.constant != height){
            NSLog(@"same");
//            self.constraintTableViewHeight.constant = height;
            if(self.delegate){
//                [self.delegate heightChange:height row:self.row];
            }
        }else{
            NSLog(@"not same");
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isReplay ? self.childItems.count + 1 : self.childItems.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isReplay && indexPath.row == self.childItems.count) {
        return 180;
    }else{
        return UITableViewAutomaticDimension;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@" isreplay %ld %d %d %ld %d",indexPath.row,indexPath.row == self.childItems.count, self.isReplay,self.childItems.count,self.row);
    if(self.isReplay && indexPath.row == self.childItems.count){
        HearsayReplyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"replayCell" forIndexPath:indexPath];
        cell.comment_id = self.comment_id;
        cell.user_id = self.userid;
        cell.textViewComment.text = @"";
        cell.delegate = self.reply;
        return cell;
    }
    CommentCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.userid = self.userid;
    cell.report = self.report;
    [cell.viewReplay setHidden:true];
    cell.constraintViewReplayWidt.constant = 0;
    [cell setupData:self.childItems[indexPath.row]];
    return cell;
}

-(void)setupData:(NSDictionary *)item{
    NSString *comment_content = [item valueForKey:@"comment_content"];
    NSString *userid = [[item valueForKey:@"comment_id"] stringValue];
    NSString *comment = [NSString stringWithFormat:@"%@ %@",userid,comment_content];
    self.comment_id = [item valueForKey:@"comment_id"];
    self.isLike = [[item valueForKey:@"status_vote"] boolValue];
    NSString *dateStr = [item valueForKey:@"created_date"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"d-MM-yyyy HH:mm:ss"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    self.labelDate.text = [date timeAgoSinceNow];
    [self.buttonLike setTitle:self.isLike ? @"Unlike" :@"Like" forState:UIControlStateNormal];
    self.childItems = [item valueForKey:@"sub_comment"] != [NSNull null]? [item valueForKey:@"sub_comment"] : nil;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:comment];
    [attr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:[comment rangeOfString:userid]];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[comment rangeOfString:comment_content]];
    self.labelComment.attributedText = attr;
}

-(void)postCommentSuccess{
    [self.tableView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)LikeOnClick:(id)sender {
    [Hearsay.instance voteCommentWithCommentId:self.comment_id withUserId:self.userid withVoteType:self.isLike ? 2 : 1 onComplete:^(HearsayResponseModel *response) {
        if(response.isSuccess && [response.status isEqualToString:@"200"]){
            [helper showMessage:response.display_message status:SUCCESS];
            self.isLike = !self.isLike;
            [self.buttonLike setTitle:self.isLike ? @"Unlike":@"Like" forState:UIControlStateNormal];
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
}
- (IBAction)ReplayOnClick:(id)sender {
    NSLog(@"replay");
    if(self.delegate){
        [self.delegate replayOnClick:self.row];
    }
    self.isReplay = true;
    [self.tableView reloadData];
}
- (IBAction)ReportOnClick:(id)sender {
    if(self.report){
        [self.report reportOnClick:self.comment_id];
    }
}

@end

//
//  HearsayCommentViewController.m
//  Chips_Example
//
//  Created by Fajar on 4/6/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "HearsayCommentViewController.h"
#import "Cips/Cips.h"
#import "CommentCellTableViewCell.h"
#import <Cips/SquadViewHelper.h>
#import "HearsayReplyCommentTableViewCell.h"
#import "Chips_Example-Swift.h"

@interface HearsayCommentViewController ()<UITableViewDelegate,UITableViewDataSource,CommentCellDelegate,HearsayReplyCommentDelegate,CommentCellReport,SheeetDelegate,HearsayLoadMoreDelegate>
{
    NSMutableArray *data;
    NSMutableArray *heightChild;
}

@end

@implementation HearsayCommentViewController
Hearsay *hearsay;
SquadViewHelper *helper;
int totalCount;
int offset;
NSString *post_id;
NSString *user_id;
int replayRow;
bool reloadReplay;
int rowBeforeReplay;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    hearsay = [Hearsay instance];
    helper = [SquadViewHelper helper];
    data = [NSMutableArray new];
    heightChild = [NSMutableArray new];
    totalCount = 1;
    offset = 0;
    replayRow = 0;
    post_id = @"100";
    user_id = @"9898";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HearsayReplyCommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellReply"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [hearsay getCommentWithPostId:post_id withUserIdIsVote:user_id withFilterUserId:@"0" withLimit:@"10" withOffset:[NSString stringWithFormat:@"%d",offset] onComplete:^(HearsayResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            [data addObjectsFromArray:[response.data objectForKey:@"main_comment"]];
            for (int i = 0; i < [[response.data objectForKey:@"main_comment"] count]; i++) {
                [heightChild addObject:[NSNumber numberWithInt:0]];
            }
            int count = [[response.data valueForKey:@"total_main_comment"] intValue];
            offset += 10;
            totalCount = data.count < count ? data.count + 2 : data.count + 1;
            self.labelTotalComment.text = count < 2 ? [NSString stringWithFormat:@"%d Comment",count] : [NSString stringWithFormat:@"%d Comments",count];
            NSLog(@"comment count = %ld  %d",data.count,totalCount);
            [self.tableView reloadData];
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return totalCount;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 200;
    }else{
        return UITableViewAutomaticDimension;
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([cell isKindOfClass:[CommentCellTableViewCell class]]){
    CommentCellTableViewCell *c = (CommentCellTableViewCell *)cell;
//    [c removeObserverTableView];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        HearsayReplyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellReply" forIndexPath:indexPath];
        cell.post_id = post_id;
        cell.user_id = user_id;
        cell.delegate = self;
        cell.textViewComment.text = @"";
        return cell;
    }
    if(totalCount != data.count + 1 && indexPath.row == totalCount - 1){
        HearsayLoadMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loadMoreCell" forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else{
        CommentCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSDictionary *item = data[indexPath.row - 1];
        cell.userid = user_id;
        cell.report = self;
        cell.reply = self;
        cell.row = indexPath.row;
        NSLog(@"height %ld, %f",indexPath.row - 1, [heightChild[indexPath.row -1] floatValue]);
        cell.constraintTableViewHeight.constant = 1000;
        cell.isReplay = replayRow == indexPath.row;
        [cell setupData:item];
//        [cell initiateObserver];
        cell.delegate = self;
//        cell.labelDate.text = [NSString stringWithFormat:@"%d",indexPath.row - 1];
        [cell.tableView reloadData];
        [cell.tableView layoutIfNeeded];
        NSLog(@"table row %ld, %f,table %f",indexPath.row - 1, [heightChild[indexPath.row -1] floatValue], cell.tableView.contentSize.height);
        cell.constraintTableViewHeight.constant = cell.tableView.contentSize.height;
        return cell;
    }
}

-(void)reportOnClick:(NSString *)comment_id{
    [[[HelperHearsay alloc] init] showAlertWithcommentID:[NSString stringWithFormat:@"%@",comment_id] withVC:self withDelegate:self];
}

-(void)alertClickedWithReportId:(NSString *)reportId withCommentId:(NSString *)commentId withReason:(NSString *)reason{
//    NSLog(@"alert %@,%@",reportId,commentId);
    [helper addLoading];
    [hearsay reportCommentWithCommentId:commentId withReportId:reportId withReason:reason withUserId:user_id onComplete:^(HearsayResponseModel *response) {
        [helper removeLoading];
        if(response.isSuccess && [response.status isEqualToString:@"200"]){
            [helper showMessage:response.display_message status:SUCCESS];
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
}


-(void)postCommentSuccess{
    replayRow = -1;
    rowBeforeReplay = 0;
    reloadReplay = false;
    offset = 0;
    [helper addLoading];
    [hearsay getCommentWithPostId:post_id withUserIdIsVote:user_id withFilterUserId:@"0" withLimit:@"10" withOffset:[NSString stringWithFormat:@"%d",offset] onComplete:^(HearsayResponseModel *response) {
        [helper removeLoading];
        if([response.status isEqualToString:@"200"]){
            [data removeAllObjects];
            [data addObjectsFromArray:[response.data objectForKey:@"main_comment"]];
            [heightChild removeAllObjects];
            for (int i = 0; i < [[response.data objectForKey:@"main_comment"] count]; i++) {
                [heightChild addObject:[NSNumber numberWithInt:0]];
            }
            int count = [[response.data valueForKey:@"total_main_comment"] intValue];
            totalCount = data.count < count ? data.count + 2 : data.count + 1;
            self.labelTotalComment.text = count < 2 ? [NSString stringWithFormat:@"%d Comment",count] : [NSString stringWithFormat:@"%d Comments",count];
            NSLog(@"comment count = %ld",data.count);
//            [self.tableView beginUpdates];
            [self.tableView reloadData];
//            [self.tableView endUpdates];
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
}

-(void)LoadMoreOnClick{
    [hearsay getCommentWithPostId:post_id withUserIdIsVote:user_id withFilterUserId:@"0" withLimit:@"10" withOffset:[NSString stringWithFormat:@"%d",offset] onComplete:^(HearsayResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            
            [data addObjectsFromArray:[response.data objectForKey:@"main_comment"]];
            for (int i = 0; i < [[response.data objectForKey:@"main_comment"] count]; i++) {
                [heightChild addObject:[NSNumber numberWithInt:0]];
            }
            NSMutableArray *indexs = [NSMutableArray new];
            for(int x = offset ;x<offset+[[response.data objectForKey:@"main_comment"] count];x++){
                [indexs addObject:[NSIndexPath indexPathForRow:x inSection:0]];
            }
            NSLog(@"loadmore %ld : %ld :%ld" ,data.count,[[response.data objectForKey:@"main_comment"] count],indexs.count);
            
            int count = [[response.data valueForKey:@"total_main_comment"] intValue];
            offset += 10;
            totalCount = data.count < count ? data.count + 2 : data.count + 1;
            self.labelTotalComment.text = count < 2 ? [NSString stringWithFormat:@"%d Comment",count] : [NSString stringWithFormat:@"%d Comments",count];
            NSLog(@"comment count = %ld",data.count);
//            [self.tableView insertRowsAtIndexPaths:indexs withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView reloadData];
            
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
}

-(void)heightChange:(CGFloat)height row:(int)row{
    NSLog(@"height changed %f,%d",height,row);
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    heightChild[row - 1] = [NSNumber numberWithFloat:height];
//    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
//    [self.tableView reloadData];
}

-(void)replayOnClick:(int)row{
    NSLog(@"replay on row %d",row);
    reloadReplay = true;
    rowBeforeReplay = replayRow;
    replayRow = row;
    NSIndexPath *path2 = [NSIndexPath indexPathForRow:rowBeforeReplay inSection:0];
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path,path2] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)shareOnClick:(id)sender {
    
}

@end

@implementation HearsayLoadMoreCell

-(void)awakeFromNib{
    [super awakeFromNib];
}

- (IBAction)LoadMoreOnClick:(id)sender {
    if(self.delegate){
        [self.delegate LoadMoreOnClick];
    }
}

@end




//
//  CommentCellTableViewCell.h
//  Chips_Example
//
//  Created by Fajar on 4/6/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HearsayReplyCommentTableViewCell.h"

@protocol CommentCellDelegate<NSObject>

-(void)heightChange:(CGFloat)height row:(int)row;
-(void)replayOnClick:(int)row;

@end

@protocol CommentCellReport

-(void)reportOnClick:(NSString *)comment_id;

@end

@interface CommentCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelComment;
@property (weak, nonatomic) IBOutlet UIImageView *imageCover;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIView *viewReplay;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonLike;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintViewReplayWidt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTableViewHeight;

@property (strong, nonatomic) NSString *userid;
@property (strong, nonatomic) NSMutableArray *childItems;
@property (nonatomic) id<CommentCellDelegate> delegate;
@property (nonatomic) id<CommentCellReport> report;
@property (nonatomic) id<HearsayReplyCommentDelegate> reply;
@property (strong, nonatomic) NSString *comment_id;
@property (nonatomic) bool isLike;
@property (nonatomic) bool isChild;
@property (nonatomic) int row;
@property (nonatomic) bool isReplay;

-(void)initiateObserver;
-(void)removeObserverTableView;
-(void)setupData:(NSDictionary *)item;

@end

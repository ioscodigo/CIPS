//
//  HearsayReplyCommentTableViewCell.h
//  Chips_Example
//
//  Created by Fajar on 4/13/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HearsayReplyCommentDelegate<NSObject>
    -(void)postCommentSuccess;
@end

@interface HearsayReplyCommentTableViewCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelCharLeft;
@property (weak, nonatomic) IBOutlet UITextView *textViewComment;
@property (weak, nonatomic) IBOutlet UIView *viewHolderTextView;

@property (nonatomic) id<HearsayReplyCommentDelegate> delegate;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *comment_id;
@property (strong, nonatomic) NSString *post_id;
@property (nonatomic) bool isReply;

@end

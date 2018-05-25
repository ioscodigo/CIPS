//
//  HearsayReplyCommentTableViewCell.m
//  Chips_Example
//
//  Created by Fajar on 4/13/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "HearsayReplyCommentTableViewCell.h"
#import <Cips/Cips.h>
#import <Cips/SquadViewHelper.h>

@implementation HearsayReplyCommentTableViewCell

SquadViewHelper *helper;

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textViewComment.delegate = self;
    self.viewHolderTextView.layer.borderWidth = 1;
    self.viewHolderTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.viewHolderTextView.layer.cornerRadius = 4;
    helper = [SquadViewHelper helper];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

-(void)textViewDidChange:(UITextView *)textView{
    int count = 1000 - textView.text.length;
    self.labelCharLeft.text = [NSString stringWithFormat:@"%d character left",count];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return textView.text.length <= 1000;
};


- (IBAction)postOnClick:(id)sender {
    if(self.comment_id){
        NSLog(@"post child");
        [helper addLoading];
        [Hearsay.instance commentReplyWithContent:self.textViewComment.text withCommentId:self.comment_id withUserId:self.user_id withEmail:@"email@aaa.com" withUsername:@"username" withArticleName:@"name" onComplete:^(HearsayResponseModel *response) {
            [helper removeLoading];
            if(response.isSuccess && [response.status isEqualToString:@"200"]){
                [helper showMessage:response.display_message status:SUCCESS];
                if(self.delegate){
                    [self.delegate postCommentSuccess];
                }
            }else{
                [helper showMessage:response.display_message status:ERROR];
            }
        }];
    }
    if(self.post_id){
        [helper addLoading];
        NSLog(@"post comment");
        [Hearsay.instance commentPostWithContent:self.textViewComment.text withUserId:self.user_id withEmail:@"email@aaa.com" withUsername:@"username" withPostId:self.post_id withArticleName:@"name" onComplete:^(HearsayResponseModel *response) {
            [helper removeLoading];
            if(response.isSuccess && [response.status isEqualToString:@"200"]){
                [helper showMessage:response.display_message status:SUCCESS];
                if(self.delegate){
                    [self.delegate postCommentSuccess];
                }
            }else{
                [helper showMessage:response.display_message status:ERROR];
            }
        }];
    }
}

@end

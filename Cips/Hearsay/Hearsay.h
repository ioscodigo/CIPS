//
//  Hearsay.h
//  Pods
//
//  Created by Fajar on 12/27/17.
//
//

#import <Foundation/Foundation.h>
#import "HearsayResponseModel.h"
#import "Cips/CipsHTTPHelper.h"

@interface Hearsay : NSObject

typedef void (^hearsayCompletion)(HearsayResponseModel *response);

-(instancetype)init __attribute__((unavailable("init not available")));

+(Hearsay *)instance;
+(void)initWithID:(NSString *)apps_id secret:(NSString *)apps_secret withCompanyId:(NSString *)companyID onComplete:(hearsayCompletion)complete;

+(void)initWithID:(NSString *)apps_id secret:(NSString *)apps_secret withCompanyId:(NSString *)companyID environment:(CIPSENVIRONMENT)env onComplete:(hearsayCompletion)complete;

-(void)getCommentWithPostId:(NSString *)post_id withUserIdIsVote:(NSString *)vote_user_id withFilterUserId:(NSString *)filter_user_id withLimit:(NSString *)limit withOffset:(NSString *)offset onComplete:(hearsayCompletion)complete;

-(void)getChildCommentWithCommentID:(NSString *)comment_id withUserIdIsVote:(NSString *)vote_user_id withFilterUserId:(NSString *)filter_user_id withLimit:(NSString *)limit withOffset:(NSString *)offset onComplete:(hearsayCompletion)complete;


-(void)commentPostWithContent:(NSString *)comment withUserId:(NSString *)user_id withEmail:(NSString *)email withUsername:(NSString *)username withPostId:(NSString *)post_id withArticleName:(NSString *)article_name onComplete:(hearsayCompletion)onComplete;
-(void)commentReplyWithContent:(NSString *)comment withCommentId:(NSString *)comment_id withUserId:(NSString *)user_id withEmail:(NSString *)email withUsername:(NSString *)username withArticleName:(NSString *)article_name onComplete:(hearsayCompletion)onComplete;

-(void)reportCommentWithCommentId:(NSString *)comment_id withReportId:(NSString *)report_id withReason:(NSString *)reason withUserId:(NSString *)userid onComplete:(hearsayCompletion)completion;

-(void)getCategoryReport:(hearsayCompletion)onComplete;

-(void)voteCommentWithCommentId:(NSString *)comment_id withUserId:(NSString *)user_id withVoteType:(int)vote onComplete:(hearsayCompletion)completion;

@end

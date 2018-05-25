//
//  HearsayAPI.h
//  Pods
//
//  Created by Fajar on 12/28/17.
//
//

#import <Foundation/Foundation.h>
#import <Cips/CipsHTTPHelper.h>
#import "../Hearsay.h"

@interface HearsayAPI : NSObject

@property (strong,nonatomic) NSString *apps_id;
@property (strong,nonatomic) NSString *company_id;
@property (strong,nonatomic) NSString *apps_secret;
@property (strong,nonatomic) NSString *token;
@property (strong,nonatomic) NSString *token_secret;
@property (nonatomic) CIPSENVIRONMENT *env;


-(id)initWithAppsId:(NSString *)apps_id withAppsSecret:(NSString*)apps_secret withCompanyID:(NSString *)company_id withEnvironment:(CIPSENVIRONMENT)env onComplete:(hearsayCompletion)complete;
-(id)initWithAppsId:(NSString *)apps_id withAppsSecret:(NSString*)apps_secret withCompanyID:(NSString *)company_id onComplete:(hearsayCompletion)complete;
-(void)setEnvironment:(CIPSENVIRONMENT)env onComplete:(hearsayCompletion)complete;

-(void)getCommentWithPostId:(NSString *)post_id withUserIdIsVote:(NSString *)vote_user_id withFilterUserId:(NSString *)filter_user_id withLimit:(NSString *)limit withOffset:(NSString *)offset onComplete:(hearsayCompletion)complete;

-(void)getChildCommentWithCommentID:(NSString *)comment_id withUserIdIsVote:(NSString *)vote_user_id withFilterUserId:(NSString *)filter_user_id withLimit:(NSString *)limit withOffset:(NSString *)offset onComplete:(hearsayCompletion)complete;

-(void)postCommentWithUserId:(NSString *)userid withEmail:(NSString *)email withUsername:(NSString *)username withPostid:(NSString *)post_id withArticleName:(NSString *)article_name withContent:(NSString *)content onComplete:(hearsayCompletion)completion;

-(void)postChildCommentWithUserId:(NSString *)userid withEmail:(NSString *)email withUsername:(NSString *)username withPostid:(NSString *)post_id withCommentId:(NSString *)parent_id withArticleName:(NSString *)article_name withContent:(NSString *)content onComplete:(hearsayCompletion)completion;

-(void)reportCommentWithCommentId:(NSString *)comment_id withReportId:(NSString *)report_id withReason:(NSString *)reason withUserId:(NSString *)userid onComplete:(hearsayCompletion)completion;

-(void)getCategoryReport:(hearsayCompletion)onComplete;

-(void)voteCommentWithCommentId:(NSString *)comment_id withUserId:(NSString *)user_id withVoteType:(int)vote onComplete:(hearsayCompletion)completion;
@end

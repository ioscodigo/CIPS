//
//  Hearsay.m
//  Pods
//
//  Created by Fajar on 12/27/17.
//
//

#import "Hearsay.h"
#import "Internal/HearsayAPI.h"

@implementation Hearsay



//SquadAPI *api;

static Hearsay *obj = nil;
HearsayAPI *hearsay_api;

+(Hearsay*)instance
{
    @synchronized([Hearsay class])
    {
        if (!obj)
            NSAssert(false,@"Instance not available, please init with clientid and client secret");
        
        return obj;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([Hearsay class])
    {
        NSAssert(obj == nil, @"Attempted to allocate a second instance of a singleton.");
        obj = [super alloc];
        return obj;
    }
    
    return nil;
}

-(id)init {
    return nil;
}

+(void)initWithID:(NSString *)apps_id secret:(NSString *)apps_secret withCompanyId:(NSString *)companyID onComplete:(hearsayCompletion)complete{
    [Hearsay alloc];
    hearsay_api = [[HearsayAPI alloc] initWithAppsId:(NSString *)apps_id withAppsSecret:apps_secret withCompanyID:companyID withEnvironment:PRODUCTION onComplete:complete];
}

+(void)initWithID:(NSString *)apps_id secret:(NSString *)apps_secret withCompanyId:(NSString *)companyID environment:(CIPSENVIRONMENT)env onComplete:(hearsayCompletion)complete{
    [Hearsay alloc];
    hearsay_api = [[HearsayAPI alloc] initWithAppsId:(NSString *)apps_id withAppsSecret:apps_secret withCompanyID:companyID withEnvironment:env onComplete:complete];
}

-(void)getCommentWithPostId:(NSString *)post_id withUserIdIsVote:(NSString *)vote_user_id withFilterUserId:(NSString *)filter_user_id withLimit:(NSString *)limit withOffset:(NSString *)offset onComplete:(hearsayCompletion)complete{
    [hearsay_api getCommentWithPostId:post_id withUserIdIsVote:vote_user_id withFilterUserId:filter_user_id withLimit:limit withOffset:offset onComplete:complete];
}

-(void)getChildCommentWithCommentID:(NSString *)comment_id withUserIdIsVote:(NSString *)vote_user_id withFilterUserId:(NSString *)filter_user_id withLimit:(NSString *)limit withOffset:(NSString *)offset onComplete:(hearsayCompletion)complete{
    [hearsay_api getChildCommentWithCommentID:comment_id withUserIdIsVote:vote_user_id withFilterUserId:filter_user_id withLimit:limit withOffset:offset onComplete:complete];
}


-(void)commentPostWithContent:(NSString *)comment withUserId:(NSString *)user_id withEmail:(NSString *)email withUsername:(NSString *)username withPostId:(NSString *)post_id withArticleName:(NSString *)article_name onComplete:(hearsayCompletion)onComplete{
    [hearsay_api postCommentWithUserId:user_id withEmail:email withUsername:username withPostid:post_id withArticleName:article_name withContent:comment onComplete:onComplete];
}

-(void)commentReplyWithContent:(NSString *)comment withCommentId:(NSString *)comment_id withUserId:(NSString *)user_id withEmail:(NSString *)email withUsername:(NSString *)username withArticleName:(NSString *)article_name onComplete:(hearsayCompletion)onComplete{
    [hearsay_api postChildCommentWithUserId:user_id withEmail:email withUsername:username withPostid:@"0" withCommentId:comment_id withArticleName:article_name withContent:comment onComplete:onComplete];
}

-(void)reportCommentWithCommentId:(NSString *)comment_id withReportId:(NSString *)report_id withReason:(NSString *)reason withUserId:(NSString *)userid onComplete:(hearsayCompletion)completion{
    [hearsay_api reportCommentWithCommentId:comment_id withReportId:report_id withReason:reason withUserId:userid onComplete:completion];
}

-(void)getCategoryReport:(hearsayCompletion)onComplete{
    [hearsay_api getCategoryReport:onComplete];
}

-(void)voteCommentWithCommentId:(NSString *)comment_id withUserId:(NSString *)user_id withVoteType:(int)vote onComplete:(hearsayCompletion)completion{
    [hearsay_api voteCommentWithCommentId:comment_id withUserId:user_id withVoteType:vote onComplete:completion];
}


@end

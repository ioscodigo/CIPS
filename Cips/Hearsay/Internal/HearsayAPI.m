//
//  HearsayAPI.m
//  Pods
//
//  Created by Fajar on 12/28/17.
//
//

#import "HearsayAPI.h"
#import "HearsayConstant.h"

#define HEARSAY_BASE_PRODUCTION @"http://api.hearsay.id/"
#define HEARSAY_BASE_SANDBOX @"http://api.sandbox.hearsay.id/"

@implementation HearsayAPI

CipsHTTPHelper *hearsay_helper;
NSString *hearsay_base_api;

- (id)init
{
    return [self initWithAppsId:@"" withAppsSecret:@"" withCompanyID:@"" withEnvironment:PRODUCTION onComplete:^(HearsayResponseModel *response) {
        
    }];
}

-(id)initWithAppsId:(NSString *)apps_id withAppsSecret:(NSString*)apps_secret withCompanyID:(NSString *)company_id withEnvironment:(CIPSENVIRONMENT)env onComplete:(hearsayCompletion)complete{
    self = [super init];
    if (self) {
        self.apps_id = apps_id;
        self.company_id = company_id;
        self.apps_secret = apps_secret;
        hearsay_helper = [CipsHTTPHelper instance];
        [self setEnvironment:env onComplete:complete];
    }
    return self;
}
-(id)initWithAppsId:(NSString *)apps_id withAppsSecret:(NSString*)apps_secret withCompanyID:(NSString *)company_id onComplete:(hearsayCompletion)complete{
    return [self initWithAppsId:apps_id withAppsSecret:apps_secret withCompanyID:company_id withEnvironment:PRODUCTION onComplete:complete];
}

-(void)setEnvironment:(CIPSENVIRONMENT)env onComplete:(hearsayCompletion)complete{
    if(env == PRODUCTION) {
        hearsay_base_api = HEARSAY_BASE_PRODUCTION;
    }
    if(env == SANDBOX){
        hearsay_base_api = HEARSAY_BASE_SANDBOX;
    }
    [self getToken:complete];
}

-(void)post:(NSString *)url withHeader:(NSDictionary *)header withParameter:(NSDictionary *)param onComplete:(hearsayCompletion)complete{
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithDictionary:header];
    [headers addEntriesFromDictionary:@{@"token":self.token}];
    [self request:url withMethod:POST withHeader:headers withParamater:param onComplete:complete];
}

-(void)post:(NSString *)url withParameter:(NSDictionary *)param onComplete:(hearsayCompletion)complete{
    [self post:url withHeader:@{} withParameter:param onComplete:complete];
}

-(void)request:(NSString *)url withMethod:(HTTPMethod)method withHeader:(NSDictionary *)header withParamater:(NSDictionary *)param onComplete:(hearsayCompletion)complete{
    [hearsay_helper requestJSONWithMethod:method WithUrl:[NSString stringWithFormat:@"%@%@",hearsay_base_api,url] withParameter:param withHeader:header withBlock:^(CipsHTTPResponse *respon) {
        HearsayResponseModel *responHearsay = [[HearsayResponseModel alloc] init];
        if(respon.error){
            responHearsay.isSuccess = false;
            responHearsay.error = respon.error;
        }else{
            responHearsay.error = nil;
            responHearsay.isSuccess = true;
        }
        if(respon.data){
            responHearsay.message = [respon.data objectForKey:@"message"];
            responHearsay.display_message = [respon.data objectForKey:@"display_message"];
            responHearsay.status = [NSString stringWithFormat:@"%@",[respon.data objectForKey:@"status"]];
            responHearsay.time = [respon.data objectForKey:@"timestamp"];
            responHearsay.data = [respon.data objectForKey:@"data"];
        }
        complete(responHearsay);
    }];
}

-(void)getToken:(hearsayCompletion)onComplete{
    NSDictionary *param = @{
                           @"company_id":self.company_id,
                           @"apps_id":self.apps_id,
                           @"apps_secret":self.apps_secret
                           };
    [self request:HEARSAY_TOKEN_GET withMethod:POST withHeader:nil withParamater:param onComplete:^(HearsayResponseModel *response) {
        if(response.isSuccess && [response.status isEqualToString:@"200"]){
            self.token = [response.data objectForKey:@"access_token"];
        }
        onComplete(response);
    }];
}


-(void)getMainComment:(NSString *)post_id withUserId:(NSString *)user_id withLimit:(NSString *)limit withOffset:(NSString *)offset{
    
}

-(void)getCommentWithPostId:(NSString *)post_id withUserIdIsVote:(NSString *)vote_user_id withFilterUserId:(NSString *)filter_user_id withLimit:(NSString *)limit withOffset:(NSString *)offset onComplete:(hearsayCompletion)complete{
    NSDictionary *param = @{
                            @"user_id":filter_user_id,
                            @"user_vote_id":vote_user_id,
                            @"post_id":post_id,
                            @"limit":limit,
                            @"offset":offset
                            };
    [self post:HEARSAY_COMMENT_GET withParameter:param onComplete:complete];
}

-(void)getChildCommentWithCommentID:(NSString *)comment_id withUserIdIsVote:(NSString *)vote_user_id withFilterUserId:(NSString *)filter_user_id withLimit:(NSString *)limit withOffset:(NSString *)offset onComplete:(hearsayCompletion)complete{
    NSDictionary *param = @{
                            @"user_id":filter_user_id,
                            @"user_vote_id":vote_user_id,
                            @"post_id":@"0",
                            @"comment_id":comment_id,
                            @"limit":limit,
                            @"offset":offset
                            };
    [self post:HEARSAY_COMMENT_CHILD_GET withParameter:param onComplete:complete];
}


-(void)postCommentWithUserId:(NSString *)userid withEmail:(NSString *)email withUsername:(NSString *)username withPostid:(NSString *)post_id withParentId:(NSString *)parent_id withArticleName:(NSString *)article_name withContent:(NSString *)content onComplete:(hearsayCompletion)completion{
    NSDictionary *param = @{
                            @"user_id":userid,
                            @"email":email,
                            @"username":username,
                            @"nickname":username,
                            @"post_id":post_id,
                            @"parent_id":parent_id,
                            @"article_name":article_name,
                            @"comment_content":content
                            };
    NSLog(@"param post %@",param);
    [self post:HEARSAY_COMMENT_POST withParameter:param onComplete:completion];
}

-(void)postCommentWithUserId:(NSString *)userid withEmail:(NSString *)email withUsername:(NSString *)username withPostid:(NSString *)post_id withArticleName:(NSString *)article_name withContent:(NSString *)content onComplete:(hearsayCompletion)completion{
    [self postCommentWithUserId:userid withEmail:email withUsername:username withPostid:post_id withParentId:@"0" withArticleName:article_name withContent:content onComplete:completion];
}

-(void)postChildCommentWithUserId:(NSString *)userid withEmail:(NSString *)email withUsername:(NSString *)username withPostid:(NSString *)post_id withCommentId:(NSString *)parent_id withArticleName:(NSString *)article_name withContent:(NSString *)content onComplete:(hearsayCompletion)completion{
    [self postCommentWithUserId:userid withEmail:email withUsername:username withPostid:post_id withParentId:parent_id withArticleName:article_name withContent:content onComplete:completion];
}

-(void)getCategoryReport:(hearsayCompletion)onComplete{
    [hearsay_helper request:GET withURL:[NSString stringWithFormat:@"%@%@",hearsay_base_api,HEARSAY_COMMENT_REPORT_CATEGORY] withHeaders:@{@"token":self.token} withBlock:^(CipsHTTPResponse *respon) {
        HearsayResponseModel *responHearsay = [[HearsayResponseModel alloc] init];
        if(respon.error){
            responHearsay.isSuccess = false;
            responHearsay.error = respon.error;
        }else{
            responHearsay.error = nil;
            responHearsay.isSuccess = true;
        }
        if(respon.data){
            responHearsay.message = [respon.data objectForKey:@"message"];
            responHearsay.display_message = [respon.data objectForKey:@"display_message"];
            responHearsay.status = [NSString stringWithFormat:@"%@",[respon.data objectForKey:@"status"]];
            responHearsay.time = [respon.data objectForKey:@"timestamp"];
            responHearsay.data = [respon.data objectForKey:@"data"];
        }
        onComplete(responHearsay);
    }];
}

-(void)reportCommentWithCommentId:(NSString *)comment_id withReportId:(NSString *)report_id withReason:(NSString *)reason withUserId:(NSString *)userid onComplete:(hearsayCompletion)completion{
    NSDictionary *param = @{
                            @"comment_id":comment_id,
                            @"category":report_id,
                            @"user_id":userid,
                            @"action":@"3",
                            @"reason":reason
                            };
    [self post:HEARSAY_COMMENT_REPORT withParameter:param onComplete:completion];
}


-(void)voteCommentWithCommentId:(NSString *)comment_id withUserId:(NSString *)user_id withVoteType:(int)vote onComplete:(hearsayCompletion)completion{
    NSDictionary *param = @{
                            @"comment_id":comment_id,
                            @"user_id":user_id,
                            @"vote":[NSString stringWithFormat:@"%d",vote]
                            };
    [self post:HEARSAY_COMMENT_VOTE withParameter:param onComplete:completion];
}

@end

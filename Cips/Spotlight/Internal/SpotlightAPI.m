//
//  SpotlightAPI.m
//  Pods
//
//  Created by Fajar on 1/8/18.
//
//

#import "SpotlightAPI.h"
#import "SpotlightConstant.h"

#define SPOTLIGHT_BASE_PRODUCTION @"https://api.spotlight.id/"
#define SPOTLIGHT_BASE_SANDBOX @"https://api.sandbox.spotlight.id/"

@implementation SpotlightAPI

CipsHTTPHelper *spotlight_helper;
NSString *spotlight_access_token;
NSString *base_api;
NSString *sp_apps_secret;
NSString *sp_apps_id;
NSString *sp_company_id;


-(id)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id completion:(void (^)(bool isSuccess, NSString *responseToken))block{
    if (self) {
        _currentEnvironment = PRODUCTION;
        sp_apps_id = apps_id;
        sp_apps_secret = apps_secret;
        sp_company_id = company_id;
        base_api = SPOTLIGHT_BASE_PRODUCTION;
        spotlight_helper = [CipsHTTPHelper instance];
        spotlight_access_token = @"";
        [self spotlightLoginWithAppsSecret:apps_secret withClientid:apps_id withCompanyid:company_id completion:^(bool isSuccess, NSString *responseToken) {
            block(isSuccess,responseToken);
        }];
    }
    return self;
}
-(id)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id withEnvironment:(CIPSENVIRONMENT)env completion:(void (^)(bool isSuccess, NSString *responseToken))block{
    self = [super init];
    if (self) {
        _currentEnvironment = env;
        sp_apps_id = apps_id;
        sp_apps_secret = apps_secret;
        sp_company_id = company_id;
        switch (env) {
            case PRODUCTION:
                base_api = SPOTLIGHT_BASE_PRODUCTION;
                break;
            case SANDBOX:
                base_api = SPOTLIGHT_BASE_SANDBOX;
                break;
            default:
                break;
        }
        spotlight_helper = [CipsHTTPHelper instance];
        spotlight_access_token = @"";
        [self spotlightLoginWithAppsSecret:apps_secret withClientid:apps_id withCompanyid:company_id completion:^(bool isSuccess, NSString *responseToken) {
            block(isSuccess,responseToken);
        }];
    }
    return self;
}


-(void)spotlightLoginWithAppsSecret:(NSString *)apps_secret withClientid:(NSString *)apps_id withCompanyid:(NSString *)company_id completion:(void (^)(bool isSuccess,NSString *responseToken))block {
    NSDictionary *param = @{
                            @"company_id":company_id,
                            @"apps_id":apps_id,
                            @"apps_secret":apps_secret
                            };
    [self spotlightPostWithURL:SPOTLIGHT_LOGIN withParam:param withHeader:@{} withBlock:^(SpotlightResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            NSString *token = [response.data objectForKey:@"access_token"];
            spotlight_access_token = token;
            block(true,token);
        }else{
            spotlight_access_token = @"";
            NSLog(@"log %@",response.display_message);
            block(false,@"");
        }
    }];
}

-(void)spotlightChannelListWithUserId:(NSString *)user_id completion:(spotlightCompletion)respon{
    [self spotlightGetWithURL:SPOTLIGHT_CHANNEL withHeader:@{@"userid":user_id} withBlock:respon];
}

-(void)spotlightHomepageWithChannel:(NSString *)channel withType:(SPOTLIGHT_HOMEPAGE_TYPE)type page:(int)page limit:(int)limit completion:(spotlightCompletion)respon{
    NSString *baseurl = @"";
    NSString *limitstr = @"";
    switch (type) {
        case HOMEPAGE_HEADLINE:
            baseurl = SPOTLIGHT_HOMEPAGE_HEADLINE;
            break;
        case HOMEPAGE_STORY:
            baseurl = SPOTLIGHT_HOMEPAGE_STORY;
            break;
        case HOMEPAGE_EDITOR_CHOICE:
            baseurl = SPOTLIGHT_HOMEPAGE_EDITOR_CHOICE;
            break;
        case HOMEPAGE_NEWSBOOST:
            baseurl = SPOTLIGHT_HOMEPAGE_NEWSBOOST;
            break;
        case HOMEPAGE_COMMERCIAL:
            baseurl = SPOTLIGHT_HOMEPAGE_COMMERCIAL;
            break;
        case HOMEPAGE_BOXTYPE:
            baseurl = SPOTLIGHT_HOMEPAGE_BOXTYPE;
            limitstr = [NSString stringWithFormat:@"?limitArticle=%d",limit];
            break;
        default:
            break;
    }
    baseurl = [NSString stringWithFormat:@"%@%@%@",baseurl,channel,limitstr];
    [self spotlightGetWithURL:baseurl withHeader:@{} withBlock:respon];
}

-(void)spotlightArticleWithType:(SPOTLIGHT_ARTICLE_TYPE)type withUserId:(NSString *)user_id withParam:(NSString *)param page:(int)page limit:(int)limit completion:(spotlightCompletion)respon{
    NSString *baseurl = @"";
    switch (type) {
        case ARTICLE_HOMEPAGE:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_HOMEPAGE,page,limit];
            break;
        case ARTICLE_GALLERY:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_GALLERY,page,limit];
            break;
        case ARTICLE_CHANNEL_GALLERY:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_GALLERY_CHANNEL,param,page,limit];
            break;
        case ARTICLE_CHANNEL_STANDARD:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_CHANNEL_STANDARD,param,page,limit];
            break;
        case ARTICLE_CHANNEL_GROUP:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_GROUP_CHANNEL,param,page,limit];
            break;
        case ARTICLE_GROUP:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_GROUP,page,limit];
            break;
        case ARTICLE_AROUND_ME:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_AROUND_ME,param,page,limit];
            break;
        case ARTICLE_CHANNEL:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_CHANNEL,param,page,limit];
            break;
        case ARTICLE_HOMEPAGE_STANDARD:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_STANDARD_HOMEPAGE,page,limit];
            break;
        case ARTICLE_SEARCH:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_SEARCH,param,limit];
            break;
        case ARTICLE_DETAIL:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_ARTICLE_DETAIL,param];
            break;
        default:
            break;
    }
    [self spotlightGetWithURL:baseurl withHeader:@{@"userid":user_id} withBlock:respon];
}

-(void)spotlightShareArticleWithParam:(NSDictionary *)param withUserId:(NSString *)user_id withBlock:(spotlightCompletion)block{
    [self spotlightPostWithURL:SPOTLIGHT_ARTICLE_SHARE withParam:param withHeader:@{@"userid":user_id} withBlock:block];
}

-(void)spotlighStoryWithType:(SPOTLIGHT_STORY_TYPE)type withUserId:(NSString *)user_id withParam:(NSString *)param page:(int)page limit:(int)limit withBlock:(spotlightCompletion)block{
    NSString *baseurl = @"";
    switch (type) {
        case STORY_HOMEPAGE:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_STORY_HOMEPAGE,page,limit,param];
            break;
        case STORY_DETAIL:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_STORY_DETAIL,param,limit];
            break;
        case STORY_CHANNEL:
            baseurl = [NSString stringWithFormat:SPOTLIGHT_STORY_CHANNEL,param,page,limit,limit];
            break;
        default:
            break;
    }
    [self spotlightGetWithURL:baseurl withHeader:@{@"userid":user_id} withBlock:block];
}

-(void)spotlightStoryShareWithParam:(NSDictionary *)param withBlock:(spotlightCompletion)block{
    [self spotlightPostWithURL:SPOTLIGHT_STORY_SHARE withParam:param withHeader:@{@"userid":[param objectForKey:@"userid"]} withBlock:block];
}

-(void)spotlightReactionListWithParam:(NSString *)param withUserId:(NSString *)user_id withBlock:(spotlightCompletion)block{
    [self spotlightGetWithURL:[NSString stringWithFormat:SPOTLIGHT_REACTION_LIST,param] withHeader:@{@"userid":user_id} withBlock:block];
}

-(void)spotlightReactionPostWithParam:(NSDictionary *)param withUserId:(NSString *)user_id withBlock:(spotlightCompletion)block{
    [self spotlightPostWithURL:SPOTLIGHT_REACTION_POST withParam:param withHeader:@{@"userid":user_id} withBlock:block];
}

-(void)spotlightLiveStreamingWithChannel:(NSString *)channel withUserId:(NSString *)user_id withBlock:(spotlightCompletion)block{
    [self spotlightGetWithURL:[NSString stringWithFormat:SPOTLIGHT_LIVE_STREAMING_CHANNEL,channel] withHeader:@{@"userid":user_id} withBlock:block]
    ;
}

-(void)spotlightLiveStreamingShareWithParam:(NSDictionary *)param withBlock:(spotlightCompletion)block{
    [self spotlightPostWithURL:SPOTLIGHT_LIVE_STREAMING_SHARE withParam:param withHeader:@{@"userid":[param objectForKey:@"userid"]} withBlock:block];
}


-(void)spotlightRequest:(NSString *)url withMethod:(HTTPMethod)method withHeader:(NSDictionary *)header withParam:(NSDictionary *)param completion:(spotlightCompletion)block{
    NSLog(@"REQUEST SPOTLIGHT baseurl %@",url);
    [spotlight_helper requestJSONWithMethod:method WithUrl:[NSString stringWithFormat:@"%@%@",base_api,url] withParameter:param withHeader:header withBlock:^(CipsHTTPResponse *respon) {
        NSLog(@"SPOTLIGHT response %@",[NSString stringWithFormat:@"%@%@",base_api,url]);
        NSLog(@"SPORLIGHT response %@",respon.responString);
        SpotlightResponseModel *responSpotlight = [[SpotlightResponseModel alloc] init];
        if(respon.error){
            responSpotlight.isSucces = false;
            responSpotlight.error = respon.error;
            
        }else{
            responSpotlight.error = nil;
            responSpotlight.isSucces = true;
        }
        if(respon.data){
            responSpotlight.message = [respon.data objectForKey:@"message"];
            responSpotlight.display_message = [respon.data objectForKey:@"display_message"];
            responSpotlight.status = [NSString stringWithFormat:@"%@",[respon.data objectForKey:@"status"]];
            responSpotlight.time = [respon.data objectForKey:@"timestamp"];
            responSpotlight.data = [respon.data objectForKey:@"data"];
        }
        block(responSpotlight);
    }];
}

-(void)spotlightPostWithURL:(NSString *)url withParam:(NSDictionary *)param withHeader:(NSDictionary *)header withBlock:(spotlightCompletion)block{
    NSMutableDictionary *headers = [header mutableCopy];
    [headers addEntriesFromDictionary:@{@"x-access-token" : spotlight_access_token}];
    [self spotlightRequest:url withMethod:POST withHeader:headers withParam:param completion:block];
}



-(void)spotlightGetWithURL:(NSString *)url withHeader:(NSDictionary *)header withBlock:(spotlightCompletion)block{
    NSMutableDictionary *headers = [header mutableCopy];
    [headers addEntriesFromDictionary:@{@"x-access-token" : spotlight_access_token}];
    [self spotlightRequest:url withMethod:GET withHeader:headers withParam:nil completion:block];
}

-(void)setEnvironment:(CIPSENVIRONMENT)env onComplete:(void (^)(bool isSuccess, NSString *responseToken))block{
    _currentEnvironment = env;
    switch (env) {
        case PRODUCTION:
            base_api = SPOTLIGHT_BASE_PRODUCTION;
            break;
        case SANDBOX:
            base_api = SPOTLIGHT_BASE_SANDBOX;
            break;
        default:
            break;
    }
    [self spotlightLoginWithAppsSecret:sp_apps_secret withClientid:sp_apps_id withCompanyid:sp_company_id completion:block];
}


@end

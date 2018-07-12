//
//  Spotlight.m
//  Pods
//
//  Created by Fajar on 1/8/18.
//
//

#import "Spotlight.h"
#import "Internal/SpotlightAPI.h"

@implementation Spotlight

SpotlightAPI *apiSpotlight;
static Spotlight *objSpotlight = nil;


+(Spotlight*)instance
{
    @synchronized([Spotlight class])
    {
        if (!objSpotlight)
            NSAssert(false,@"Instance not available, please init with clientid and client secret");
        
        return objSpotlight;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([Spotlight class])
    {
        NSAssert(objSpotlight == nil, @"Attempted to allocate a second instance of a singleton.");
        objSpotlight = [super alloc];
        return objSpotlight;
    }
    
    return nil;
}

-(id)init {
    return nil;
}

+(void)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id completion:(void (^)(bool isSuccess, NSString *responseToken))block{
    [Spotlight alloc];
    apiSpotlight = [[SpotlightAPI alloc] initWithAppsSecret:apps_secret withClientId:apps_id withCompanyId:company_id completion:block];
}

+(void)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id withEnvironment:(CIPSENVIRONMENT)env completion:(void (^)(bool isSuccess, NSString *responseToken))block{
    [Spotlight alloc];
    apiSpotlight = [[SpotlightAPI alloc] initWithAppsSecret:apps_secret withClientId:apps_id withCompanyId:company_id withEnvironment:env completion:block];
}

-(void)spotlightChannelListWithUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightChannelListWithUserId:user_id completion:complete];
}

-(void)spotlightHomepageHeadlineWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightHomepageWithChannel:channel withType:HOMEPAGE_HEADLINE page:1 limit:10 completion:complete];
}

-(void)spotlightHomepageStoryWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightHomepageWithChannel:channel withType:HOMEPAGE_STORY page:1 limit:10 completion:complete];
}

-(void)spotlightHomepageEditorChoiceWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightHomepageWithChannel:channel withType:HOMEPAGE_EDITOR_CHOICE page:1 limit:10 completion:complete];
}

-(void)spotlightHomepageNewsboostWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightHomepageWithChannel:channel withType:HOMEPAGE_NEWSBOOST page:1 limit:10 completion:complete];
}

-(void)spotlightHomepageCommercialWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightHomepageWithChannel:channel withType:HOMEPAGE_COMMERCIAL page:1 limit:10 completion:complete];
}

-(void)spotlightHomepageBoxTypeWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightHomepageWithChannel:channel withType:HOMEPAGE_BOXTYPE page:1 limit:10 completion:complete];
}

-(void)spotlightArticleStandardWithUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_HOMEPAGE_STANDARD withUserId:user_id withParam:@"" page:page limit:limit completion:complete];
}

-(void)spotlightArticleWithWithUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_HOMEPAGE withUserId:user_id withParam:@"" page:page limit:limit completion:complete];
}

-(void)spotlightArticleStandardWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_CHANNEL_STANDARD withUserId:user_id withParam:channel page:page limit:limit completion:complete];
}

-(void)spotlightArticleWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_CHANNEL withUserId:user_id withParam:channel page:page limit:limit completion:complete];
}

-(void)spotlightArticleDetailWithId:(NSString *)article_id withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_DETAIL withUserId:user_id withParam:article_id page:0 limit:0 completion:complete];
}

-(void)spotlightArticleGalleryWithUserId:(NSString *)user_id withPage:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_GALLERY withUserId:user_id withParam:@"" page:page limit:limit completion:complete];
}

-(void)spotlightArticleGalleryWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_CHANNEL_GALLERY withUserId:user_id withParam:channel page:page limit:limit completion:complete];
}

-(void)spotlightArticleGroupWithUserId:(NSString *)user_id withPage:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_GROUP withUserId:user_id withParam:@"" page:page limit:limit completion:complete];
}

-(void)spotlightArticleGroupWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_CHANNEL_GROUP withUserId:user_id withParam:channel page:page limit:limit completion:complete];
}

-(void)spotlightArticleAroundMeWithLatitude:(NSString *)latitude longitude:(NSString *)longitude radius:(NSString *)radius withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete{
    NSString *param = [NSString stringWithFormat:@"lat=%@&long=%@&radius=%@",latitude,longitude,radius];
    [apiSpotlight spotlightArticleWithType:ARTICLE_AROUND_ME withUserId:user_id withParam:param page:page limit:limit completion:complete];
}

-(void)spotlightArticleSearchWithKeyword:(NSString *)keyword withLimit:(int)limit withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightArticleWithType:ARTICLE_SEARCH withUserId:user_id withParam:keyword page:0 limit:limit completion:complete];
}

-(void)spotlightLiveStreamingWithChannel:(NSString *)channel withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightLiveStreamingWithChannel:channel withUserId:user_id withBlock:complete];
}

-(void)spotlightLiveStreamingShareWithStreamingId:(NSString *)streaming_id userid:(NSString *)user_id shareType:(NSString *)type fromEmail:(NSString *)from_email toEmail:(NSString *)to_email message:(NSString *)message onComplete:(spotlightCompletion)complete{
    NSDictionary *param = @{
                            @"live_streaming_no":streaming_id,
                            @"userid":user_id,
                            @"type_share":type,
                            @"_from_email":from_email,
                            @"_to_email":to_email,
                            @"_message":message
                            };
    [apiSpotlight spotlightLiveStreamingShareWithParam:param withBlock:complete];
}

-(void)spotlightReactionListWithArticleId:(NSString *)article_id withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightReactionListWithParam:article_id withUserId:user_id withBlock:complete];
}

-(void)spotlightReactionSubmitWithArticleId:(NSString *)articel_id withReactionNo:(NSString *)reaction_no withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete{
    NSDictionary *param = @{
                            @"article_no":articel_id,
                            @"user_reaction_no":reaction_no
                            };
    [apiSpotlight spotlightReactionPostWithParam:param withUserId:user_id withBlock:complete];
}

-(void)spotlightStoryListWithUserid:(NSString *)user_id page:(int)page limit:(int)limit limitArticle:(NSString *)limit_article onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlighStoryWithType:STORY_HOMEPAGE withUserId:user_id withParam:limit_article page:page limit:limit withBlock:complete];
}

-(void)spotlightStoryListWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit limitArticle:(NSString *)limit_article onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlighStoryWithType:STORY_CHANNEL withUserId:user_id withParam:channel page:page limit:limit withBlock:complete];
}

-(void)spotlightStoryDetailWithStoryNo:(NSString *)story_no withUserId:(NSString *)user_id limitArticle:(int)limit_article onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlighStoryWithType:STORY_DETAIL withUserId:user_id withParam:story_no page:0 limit:limit_article withBlock:complete];
}


-(void)spotlightArticleShareWithArticleNo:(NSString *)article_no withUserId:(NSString *)user_id type:(NSString *)type fromEmail:(NSString *)from_email toEmail:(NSString *)to_email message:(NSString *)message onComplete:(spotlightCompletion)complete{
    NSDictionary *param = @{
                            @"article_no":article_no,
                            @"userid":user_id,
                            @"type_share":type,
                            @"_from_email":from_email,
                            @"_to_email":to_email,
                            @"_message":message
                            };
    [apiSpotlight spotlightShareArticleWithParam:param withUserId:user_id withBlock:complete];
}

-(void)spotlightStoryShareWithStoryNo:(NSString *)story_no withUserId:(NSString *)user_id type:(NSString *)type fromEmail:(NSString *)from_email toEmail:(NSString *)to_email message:(NSString *)message onComplete:(spotlightCompletion)complete{
    NSDictionary *param = @{
                            @"story_no":story_no,
                            @"userid":user_id,
                            @"type_share":type,
                            @"_from_email":from_email,
                            @"_to_email":to_email,
                            @"_message":message
                            };
    [apiSpotlight spotlightStoryShareWithParam:param withBlock:complete];
}

-(void)spotlightChangeEnvironment:(CIPSENVIRONMENT)env onComplete:(void (^)(bool isSuccess, NSString *responseToken))block{
    [apiSpotlight setEnvironment:env onComplete:block];
}

-(void)spotlightBulkArticleWithParam:(NSArray *)slug_no withBlock:(spotlightCompletion)block{
    NSDictionary *param = @{
                            @"slug_uniq":[slug_no componentsJoinedByString:@","]
                            };
    [apiSpotlight spotlightBulkArticleWithParam:param withBlock:block];
}




@end

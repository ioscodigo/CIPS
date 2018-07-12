//
//  Spotlight.h
//  Pods
//
//  Created by Fajar on 1/8/18.
//
//

#import <Foundation/Foundation.h>
#import "SpotlightResponseModel.h"
#import "Cips/CipsHTTPHelper.h"

typedef enum {
    HOMEPAGE_HEADLINE,
    HOMEPAGE_STORY,
    HOMEPAGE_EDITOR_CHOICE,
    HOMEPAGE_NEWSBOOST,
    HOMEPAGE_COMMERCIAL,
    HOMEPAGE_BOXTYPE
} SPOTLIGHT_HOMEPAGE_TYPE;

typedef enum {
    ARTICLE_HOMEPAGE,
    ARTICLE_CHANNEL_STANDARD,
    ARTICLE_GALLERY,
    ARTICLE_CHANNEL_GALLERY,
    ARTICLE_GROUP,
    ARTICLE_CHANNEL_GROUP,
    ARTICLE_AROUND_ME,
    ARTICLE_CHANNEL,
    ARTICLE_HOMEPAGE_STANDARD,
    ARTICLE_SEARCH,
    ARTICLE_DETAIL
} SPOTLIGHT_ARTICLE_TYPE;

typedef enum{
    STORY_HOMEPAGE,
    STORY_CHANNEL,
    STORY_DETAIL
} SPOTLIGHT_STORY_TYPE;


@interface Spotlight : NSObject

typedef void (^spotlightCompletion)(SpotlightResponseModel *response);

-(instancetype)init __attribute__((unavailable("init not available")));

+(Spotlight *)instance;

+(void)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id completion:(void (^)(bool isSuccess, NSString *responseToken))block;

+(void)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id withEnvironment:(CIPSENVIRONMENT)env completion:(void (^)(bool isSuccess, NSString *responseToken))block;

-(void)spotlightChannelListWithUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete;

-(void)spotlightHomepageHeadlineWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete;

-(void)spotlightHomepageStoryWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete;

-(void)spotlightHomepageEditorChoiceWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete;

-(void)spotlightHomepageNewsboostWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete;

-(void)spotlightHomepageCommercialWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete;

-(void)spotlightHomepageBoxTypeWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleStandardWithUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleWithWithUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleStandardWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleDetailWithId:(NSString *)article_id withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleGalleryWithUserId:(NSString *)user_id withPage:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleGalleryWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleGroupWithUserId:(NSString *)user_id withPage:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleGroupWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleAroundMeWithLatitude:(NSString *)latitude longitude:(NSString *)longitude radius:(NSString *)radius withUserId:(NSString *)user_id page:(int)page limit:(int)limit onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleSearchWithKeyword:(NSString *)keyword withLimit:(int)limit withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete;

-(void)spotlightLiveStreamingWithChannel:(NSString *)channel withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete;

-(void)spotlightLiveStreamingShareWithStreamingId:(NSString *)streaming_id userid:(NSString *)user_id shareType:(NSString *)type fromEmail:(NSString *)from_email toEmail:(NSString *)to_email message:(NSString *)message onComplete:(spotlightCompletion)complete;

-(void)spotlightReactionListWithArticleId:(NSString *)article_id withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete;

-(void)spotlightReactionSubmitWithArticleId:(NSString *)articel_id withReactionNo:(NSString *)reaction_no withUserId:(NSString *)user_id onComplete:(spotlightCompletion)complete;

-(void)spotlightStoryListWithUserid:(NSString *)user_id page:(int)page limit:(int)limit limitArticle:(NSString *)limit_article onComplete:(spotlightCompletion)complete;

-(void)spotlightStoryListWithChannel:(NSString *)channel withUserId:(NSString *)user_id page:(int)page limit:(int)limit limitArticle:(NSString *)limit_article onComplete:(spotlightCompletion)complete;

-(void)spotlightStoryDetailWithStoryNo:(NSString *)story_no withUserId:(NSString *)user_id limitArticle:(int)limit_article onComplete:(spotlightCompletion)complete;

-(void)spotlightArticleShareWithArticleNo:(NSString *)article_no withUserId:(NSString *)user_id type:(NSString *)type fromEmail:(NSString *)from_email toEmail:(NSString *)to_email message:(NSString *)message onComplete:(spotlightCompletion)complete;

-(void)spotlightStoryShareWithStoryNo:(NSString *)story_no withUserId:(NSString *)user_id type:(NSString *)type fromEmail:(NSString *)from_email toEmail:(NSString *)to_email message:(NSString *)message onComplete:(spotlightCompletion)complete;

-(void)spotlightBulkArticleWithParam:(NSArray *)slug_no withBlock:(spotlightCompletion)block;

-(void)spotlightChangeEnvironment:(CIPSENVIRONMENT)env onComplete:(void (^)(bool isSuccess, NSString *responseToken))block;
@end

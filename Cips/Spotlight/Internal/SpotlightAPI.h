//
//  SpotlightAPI.h
//  Pods
//
//  Created by Fajar on 1/8/18.
//
//

#import <Foundation/Foundation.h>
#import <Cips/CipsHTTPHelper.h>
#import "../Spotlight.h"



@interface SpotlightAPI : NSObject

@property (nonatomic) CIPSENVIRONMENT currentEnvironment;

-(id)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id completion:(void (^)(bool isSuccess, NSString *responseToken))block;

-(id)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id withEnvironment:(CIPSENVIRONMENT)env completion:(void (^)(bool isSuccess, NSString *responseToken))block;

-(void)spotlightChannelListWithUserId:(NSString *)user_id completion:(spotlightCompletion)respon;

-(void)spotlightHomepageWithChannel:(NSString *)channel withType:(SPOTLIGHT_HOMEPAGE_TYPE)type page:(int)page limit:(int)limit completion:(spotlightCompletion)respon;

-(void)spotlightArticleWithType:(SPOTLIGHT_ARTICLE_TYPE)type withUserId:(NSString *)user_id withParam:(NSString *)param page:(int)page limit:(int)limit completion:(spotlightCompletion)respon;

-(void)spotlightShareArticleWithParam:(NSDictionary *)param withUserId:(NSString *)user_id withBlock:(spotlightCompletion)block;

-(void)spotlighStoryWithType:(SPOTLIGHT_STORY_TYPE)type withUserId:(NSString *)user_id withParam:(NSString *)param page:(int)page limit:(int)limit withBlock:(spotlightCompletion)block;

-(void)spotlightStoryShareWithParam:(NSDictionary *)param withBlock:(spotlightCompletion)block;

-(void)spotlightReactionListWithParam:(NSString *)param withUserId:(NSString *)user_id withBlock:(spotlightCompletion)block;

-(void)spotlightReactionPostWithParam:(NSDictionary *)param withUserId:(NSString *)user_id withBlock:(spotlightCompletion)block;

-(void)spotlightLiveStreamingWithChannel:(NSString *)channel withUserId:(NSString *)user_id withBlock:(spotlightCompletion)block;

-(void)spotlightLiveStreamingShareWithParam:(NSDictionary *)param withBlock:(spotlightCompletion)block;

-(void)spotlightBulkArticleWithParam:(NSDictionary *)param withBlock:(spotlightCompletion)block;

-(void)setEnvironment:(CIPSENVIRONMENT)env onComplete:(void (^)(bool isSuccess, NSString *responseToken))block;
@end

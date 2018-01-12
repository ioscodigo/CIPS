//
//  Spotlight.h
//  Pods
//
//  Created by Fajar on 1/8/18.
//
//

#import <Foundation/Foundation.h>
#import "SpotlightResponseModel.h"

typedef enum {
    HOMEPAGE_HEADLINE,
    HOMEPAGE_STORY,
    HOMEPAGE_EDITOR_CHOICE,
    HOMEPAGE_NEWSBOOST,
    HOMEPAGE_COMMERCIAL,
    HOMEPAGE_BOXTYPE
} SPOTLIGHT_HOMEPAGE_TYPE;


@interface Spotlight : NSObject

typedef void (^spotlightCompletion)(SpotlightResponseModel *response);

-(instancetype)init __attribute__((unavailable("init not available")));

+(Spotlight *)instance;

+(void)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id completion:(void (^)(bool isSuccess, NSString *responseToken))block;

-(void)spotlightHomepageHeadlineWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete;

@end

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

-(void)spotlightHomepageHeadlineWithChannel:(NSString *)channel onComplete:(spotlightCompletion)complete{
    [apiSpotlight spotlightHomepageWithChannel:channel withType:HOMEPAGE_HEADLINE completion:complete];
}




@end

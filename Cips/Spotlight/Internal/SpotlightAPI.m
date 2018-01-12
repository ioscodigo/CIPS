//
//  SpotlightAPI.m
//  Pods
//
//  Created by Fajar on 1/8/18.
//
//

#import "SpotlightAPI.h"
#import "SpotlightConstant.h"


#define SPOTLIGHT_PROTOCOL @"http://api.spotlight.cips.stg.codigo.id/"
#define SPOTLIGHT_BASE_API @"http://api.spotlight.cips.stg.codigo.id/"


@implementation SpotlightAPI

CipsHTTPHelper *spotlight_helper;
NSString *spotlight_access_token;


-(id)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id completion:(void (^)(bool isSuccess, NSString *responseToken))block{
    self = [super init];
    if (self) {
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
    [self spotlightPostWithURL:SPOTLIGHT_LOGIN withParam:param withBlock:^(SpotlightResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            NSString *token = [response.data objectForKey:@"access_token"];
            spotlight_access_token = token;
            block(true,token);
        }else{
            spotlight_access_token = @"";
            block(false,@"");
        }
    }];
}

-(void)spotlightHomepageWithChannel:(NSString *)channel withType:(SPOTLIGHT_HOMEPAGE_TYPE)type completion:(spotlightCompletion)respon{
    NSString *baseurl = @"";
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
            break;
        default:
            break;
    }
    baseurl = [NSString stringWithFormat:@"%@%@",baseurl,channel];
    [self spotlightGetWithURL:baseurl withBlock:respon];
}

-(void)spotlightPostWithURL:(NSString *)url withParam:(NSDictionary *)param withBlock:(spotlightCompletion)block{
    NSDictionary *header = @{
                             @"x-access-token" : spotlight_access_token};
    [self spotlightRequest:url withMethod:POST withHeader:header withParam:param completion:block];
}

-(void)spotlightGetWithURL:(NSString *)url withBlock:(spotlightCompletion)block{
    NSDictionary *header = @{
                             @"x-access-token" : spotlight_access_token};
    [self spotlightRequest:url withMethod:GET withHeader:header withParam:nil completion:block];
}


-(void)spotlightRequest:(NSString *)url withMethod:(HTTPMethod)method withHeader:(NSDictionary *)header withParam:(NSDictionary *)param completion:(spotlightCompletion)block{
    NSLog(@"REQUEST SPOTLIGHT baseurl %@",url);
    [spotlight_helper requestJSONWithMethod:method WithUrl:[NSString stringWithFormat:@"%@%@",SPOTLIGHT_BASE_API,url] withParameter:param withHeader:header withBlock:^(CipsHTTPResponse *respon) {
//        NSLog(@"SPORLIGHT response %@",respon.responString);  
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
@end

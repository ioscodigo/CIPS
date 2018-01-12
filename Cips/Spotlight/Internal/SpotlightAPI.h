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

-(id)initWithAppsSecret:(NSString *)apps_secret withClientId:(NSString*)apps_id withCompanyId:(NSString *)company_id completion:(void (^)(bool isSuccess, NSString *responseToken))block;
-(void)spotlightHomepageWithChannel:(NSString *)channel withType:(SPOTLIGHT_HOMEPAGE_TYPE)type completion:(spotlightCompletion)respon;


@end

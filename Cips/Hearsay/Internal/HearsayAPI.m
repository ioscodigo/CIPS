//
//  HearsayAPI.m
//  Pods
//
//  Created by Fajar on 12/28/17.
//
//

#import "HearsayAPI.h"

@implementation HearsayAPI

- (id)init
{
    return [self initWithSecretKey:@"" withClientid:@"" withCompanyId:@""];
}

-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid withCompanyId:(NSString *)companyID{
    self = [super init];
    if (self) {
//        client_secret = clientSecret;
//        client_id = clientid;
//        helper = [CipsHTTPHelper instance];
//        BaseAPI = SQUAD_BASE_DEVELOPMENT;
//        wrapper = helper.keyChain;
//        company_id = companyID;
    }
    return self;
}

@end

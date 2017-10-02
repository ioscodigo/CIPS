//
//  Squad.m
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import "Squad.h"
#import "Internal/SquadAPI.h"



@implementation Squad

    SquadAPI *api;

    static Squad *obj = nil;

+(Squad*)instance
{
    @synchronized([Squad class])
    {
        if (!obj)
        NSAssert(false,@"Instance not available, please init with clientid and client secret");
        
        return obj;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([Squad class])
    {
        NSAssert(obj == nil, @"Attempted to allocate a second instance of a singleton.");
        obj = [super alloc];
        return obj;
    }
    
    return nil;
}

-(id)init {
    return nil;
}

-(id)initWithID:(NSString *)clientid secret:(NSString *)clientSecret{
    [Squad alloc];
    if (self != nil) {
        api = [[SquadAPI alloc] initWithSecretKey:clientid withClientid:clientSecret];
    }
}

+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret{
    [Squad alloc];
    api = [[SquadAPI alloc] initWithSecretKey:clientSecret withClientid:clientID];
}

+(void)setEnvironment:(ENVIRONMENT)env {
    [api setEnvironment:env];
}

-(void)loginWithEmail:(NSString *)email andPassoword:(NSString *)password completion:(squadCompletion)respon{
    NSDictionary *param = @{
                            @"username":email,
                            @"email":email,
                            @"password":password,
                            @"grant_type":@"password"
                            };
    [api loginWithParam:param completion:respon];
}

-(void)registerWithEmail:(NSString *)email password:(NSString *)password fullname:(NSString *)fullname companyid:(NSString *)comp_id redirecturi:(NSString *)red_uri verifyuri:(NSString *)ver_uri completion:(squadCompletion)respon{
    NSDictionary *param = @{
                            @"email":email,
                            @"password":password,
                            @"fullname":fullname,
                            @"company_id":comp_id,
                            @"redirect_uri":red_uri,
                            @"Verify_url":ver_uri
                            };
}

-(void)getUserinfoWithToken:(NSString *)access_token respon:(void (^)(SquadResponseModel *response))block{
    NSDictionary *param = @{
                            @"access_token":access_token
                            };
}

//-(void)editUserInfoWithData:(NSDictionary *)userEdited withAccessToken

-(void)uploadImageUser:(NSString *)userid respon:(void(^)(SquadResponseModel *response))block{
    
}

-(void)refreshTokenWithToken:(NSString *)refresh_token respon:(squadCompletion)respon{
    NSDictionary *param = @{
                            @"access_token":refresh_token,
                            @"grant_tyoe":@"refresh_token"
                            };
}

@end

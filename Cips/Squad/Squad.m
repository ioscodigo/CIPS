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

-(id)initWithID:(NSString *)clientid secret:(NSString *)clientSecret withCompanyId:(NSString *)companyID{
    [Squad alloc];
    if (obj != nil) {
        api = [[SquadAPI alloc] initWithSecretKey:clientid withClientid:clientSecret withCompanyId:companyID];
        self.companyID = companyID;
    }
    return obj;
}

+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret withCompanyId:(NSString *)companyID{
    [Squad alloc];
    api = [[SquadAPI alloc] initWithSecretKey:clientSecret withClientid:clientID withCompanyId:companyID];
    Squad.instance.companyID = companyID;
}

+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret withCompanyId:(NSString *)companyID withEnvironment:(CIPSENVIRONMENT)env{
    [Squad alloc];
    api = [[SquadAPI alloc] initWithSecretKey:clientSecret withClientid:clientID withCompanyId:companyID withEnvironment:env];
    Squad.instance.companyID = companyID;
}



+(void)setEnvironment:(CIPSENVIRONMENT)env {
    [api setEnvironment:env];
}

-(void)loginWithEmail:(NSString *)email andPassword:(NSString *)password completion:(squadCompletion)respon{
    NSDictionary *param = @{
                            @"username":email,
                            @"email":email,
                            @"password":password,
                            @"grant_type":@"password"
                            };
    [api loginWithParam:param completion:respon];
}

-(void)registerFirstWithEmail:(NSString *)email password:(NSString *)password firstName:(NSString *)firstname lastName:(NSString *)lastname companyid:(NSString *)comp_id redirecturi:(NSString *)red_uri verifyuri:(NSString *)ver_uri sendEmail:(bool)isSend completion:(squadCompletion)respon{
    NSDictionary *param = @{
                            @"email":email,
                            @"password":password,
                            @"first_name":firstname,
                            @"last_name":lastname,
                            @"company_id":_companyID,
                            @"redirect_uri":red_uri,
                            @"Verify_url":ver_uri,
                            @"nomail":isSend ? @"0" : @"1"
                            };
    [api registerWithParam:param completion:respon];
}

-(void)userInfoGetWithToken:(NSString *)access_token respon:(void (^)(SquadResponseModel *response))block{
    NSDictionary *param = @{
                            @"access_token":access_token
                            };
    [api userInfoWithParam:param completion:block];
}

-(void)profileEditWithData:(NSDictionary *)userEdited respon:(squadCompletion)response{
    [api editInfoWithParam:userEdited completion:response];
}

-(void)uploadImage:(NSData *)imageData userid:(NSString *)userid accessToken:(NSString *)accessToken respon:(squadCompletion)response {
    [api uploadImageWithParam:@{@"user_id":userid,@"access_token":accessToken} imageData:imageData completion:response];
}


-(void)tokenRefreshWithToken:(NSString *)refresh_token respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"refresh_token":refresh_token,
                            @"grant_type":@"refresh_token"
                            };
    [api refreshTokenWithParam:param completion:response];
}

-(void)logoutAccessToken:(NSString *)access_token refreshToken:(NSString *)refresh_token respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"access_token":access_token,
                            @"refresh_token":refresh_token
                            };
    [api logoutWithParam:param completion:response];
}

-(void)resourceWithParamsGetWithToken:(NSString *)access_token respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"access_token":access_token
                            };
    [api getUserInfoWithParam:param completion:response];
}

-(void)emailVerifyWithUserid:(NSString *)user_id verificationCode:(NSString *)verification respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"user_id":user_id,
                            @"verification_code":verification
                            };
    [api verifyEmailWithParam:param completion:response];
}

-(void)passwordForgotWithUserid:(NSString *)userid email:(NSString *)email verifyUrl:(NSString *)verifyUrl redirectUrl:(NSString *)redirecturl respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"user_id":userid,
                            @"email":email,
                            @"verify_url":verifyUrl,
                            @"redirect_url":redirecturl
                            };
    NSLog(@"param %@",param);
    [api forgotPasswordWithParam:param completion:response];
}

-(void)emailUpdateWithAccessToken:(NSString *)access_token userid:(NSString *)userid newEmail:(NSString *)newEmail password:(NSString *)password respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"access_token":access_token,
                            @"user_id":userid,
                            @"new_email":newEmail,
                            @"password":password
                            };
    [api updateEmailWithParam:param completion:response];
}

-(void)passwordCheckWithUserid:(NSString *)userid password:(NSString *)password respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"user_id":userid,
                            @"password":password
                            };
    [api checkPasswordWithParam:param completion:response];
}

-(void)registerVerificationResendWithUserid:(NSString *)userid respon:(squadCompletion)response{
    [api resendRegistrationVerificationWithParam:@{@"user_id":userid} completion:response];
}

-(void)verificationRegisterWithUserid:(NSString *)userid code:(NSString *)code redirect:(NSString *)redirectURI respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"user_id":userid,
                            @"verification_code":code,
                            @"redirect_uri":redirectURI
                            };
    [api registerVerificationWithParam:param completion:response];
}

-(void)passwordUpdateWithAccessToken:(NSString *)accessToken userid:(NSString *)userid oldPassword:(NSString *)oldPass newPassword:(NSString *)newPass respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"access_token":accessToken,
                            @"user_id":userid,
                            @"new_password":newPass,
                            @"old_password":oldPass
                            };
    [api updatePasswordWithParam:param completion:response];
}

-(void)verificationRegisterResend:(NSString *)email respon:(squadCompletion)response{
    [api resendVerificationRegisterWithParam:@{@"email":email} completion:response];
}


-(void)getListCountry:(squadCompletion)response{
    [api getListCountryWithCompletion:response];
}

-(void)getListCityWithCountryId:(NSString *)countryID respon:(squadCompletion)response{
    [api getListCityWithCountryId:countryID completion:response];
}

-(void)socialCheckFromTwitterWithUserId:(NSString *)userid withAccessToken:(NSString *)access_token withAcessTokenScret:(NSString *)token_secret withConsumerKey:(NSString *)consumer_key withConsumerSecret:(NSString *)consumer_secret respon:(squadCompletion)response{
    [self socialCheckFrom:@"twitter" withUserId:userid withAccessToken:access_token withAcessTokenScret:token_secret withConsumerKey:consumer_key withConsumerSecret:consumer_secret respon:response];
}


-(void)socialCheckFromFacebookWithAccessToken:(NSString *)access_token withUserId:(NSString *)userid respon:(squadCompletion)response{
    [self socialCheckFrom:@"facebook" withUserId:userid withAccessToken:access_token withAcessTokenScret:@"1" withConsumerKey:@"1" withConsumerSecret:@"1" respon:response];
}

-(void)socialCheckFrom:(NSString *)from withUserId:(NSString *)userid withAccessToken:(NSString *)access_token withAcessTokenScret:(NSString *)token_secret withConsumerKey:(NSString *)consumer_key withConsumerSecret:(NSString *)consumer_secret respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"social_id":userid,
                            @"social_from":from,
                            @"access_token":access_token,
                            @"access_token_secret":token_secret,
                            @"consumer_key":consumer_key,
                            @"consumer_secret":consumer_secret
                            };
    NSLog(@"Param social %@",param);
    [api socialLogin:CHECK withParam:param withCompletion:response];
}
-(void)socialLoginFromFacebookWithEmail:(NSString *)email withPassword:(NSString *)pass withUserId:(NSString *)userid withAccessToken:(NSString *)access_token respon:(squadCompletion)response{
    [self socialLoginFrom:@"facebook" withEmail:email withPassword:pass withUserId:userid withAccessToken:access_token withAcessTokenScret:@"1" withConsumerKey:@"1" withConsumerSecret:@"1" respon:response];
}


-(void)socialLoginFromTwitterWithEmail:(NSString *)email withPassword:(NSString *)pass withUserId:(NSString *)userid withAccessToken:(NSString *)access_token withAcessTokenScret:(NSString *)token_secret withConsumerKey:(NSString *)consumer_key withConsumerSecret:(NSString *)consumer_secret respon:(squadCompletion)response{
    [self socialLoginFrom:@"twitter" withEmail:email withPassword:pass withUserId:userid withAccessToken:access_token withAcessTokenScret:token_secret withConsumerKey:consumer_key withConsumerSecret:consumer_secret respon:response];
}

-(void)socialLoginFrom:(NSString *)from withEmail:(NSString *)email withPassword:(NSString *)pass withUserId:(NSString *)userid withAccessToken:(NSString *)access_token withAcessTokenScret:(NSString *)token_secret withConsumerKey:(NSString *)consumer_key withConsumerSecret:(NSString *)consumer_secret respon:(squadCompletion)response{
    NSDictionary *param = @{
                            @"social_id":userid,
                            @"from":from,
                            @"access_token":access_token,
                            @"access_token_secret":token_secret,
                            @"consumer_key":consumer_key,
                            @"consumer_secret":consumer_secret,
                            @"email":email,
                            @"password":pass,
                            @"username":email,
                            @"grant_type":@"password"
                            };
    NSLog(@"Social Login %@",param);
    [api socialLogin:LOGIN withParam:param withCompletion:response];
}

-(void)socialRegisterFrom:(NSString *)from withEmail:(NSString *)email withPassword:(NSString *)pass withUserId:(NSString *)userid withAccessToken:(NSString *)access_token withAcessTokenScret:(NSString *)token_secret withConsumerKey:(NSString *)consumer_key withConsumerSecret:(NSString *)consumer_secret firstName:(NSString *)firstname lastName:(NSString *)lastname companyid:(NSString *)comp_id redirecturi:(NSString *)red_uri verifyuri:(NSString *)ver_uri sendEmail:(bool)isSend completion:(squadCompletion)respon{
    NSDictionary *param = @{
                            @"email":email,
                            @"password":pass,
                            @"first_name":firstname,
                            @"last_name":lastname,
                            @"company_id":_companyID,
                            @"redirect_uri":red_uri,
                            @"Verify_url":ver_uri,
                            @"social_id":userid,
                            @"from":from,
                            @"access_token":access_token,
                            @"access_token_secret":token_secret,
                            @"consumer_key":consumer_key,
                            @"consumer_secret":consumer_secret,
                            @"nomail":isSend ? @"0" : @"1"
                            };
    [api socialLogin:REGISTER withParam:param withCompletion:respon];
}



@end

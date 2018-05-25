//
//  Squad.h
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import <Foundation/Foundation.h>
#import "SquadResponseModel.h"
#import "Cips/CipsHTTPHelper.h"




typedef void (^squadCompletion)(SquadResponseModel *response);

@protocol LoginWithTwitterDelegate

-(void)LoginWithTwitter;

@end

@interface Squad : NSObject

@property (nonatomic,strong) NSString *clientID;
@property (nonatomic,strong) NSString *clientSecret;
@property (nonatomic,strong) NSString *companyID;
@property (nonatomic) id<LoginWithTwitterDelegate> twitterDelegate;


-(instancetype)init __attribute__((unavailable("init not available")));

+(Squad *)instance;
+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret withCompanyId:(NSString *)companyID;
+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret withCompanyId:(NSString *)companyID withEnvironment:(CIPSENVIRONMENT)env;
-(void)loginWithEmail:(NSString *)email andPassword:(NSString *)password completion:(squadCompletion)respon;
-(void)registerFirstWithEmail:(NSString *)email password:(NSString *)password firstName:(NSString *)firstname lastName:(NSString *)lastname companyid:(NSString *)comp_id redirecturi:(NSString *)red_uri verifyuri:(NSString *)ver_uri sendEmail:(bool)isSend completion:(squadCompletion)respon;
-(void)userInfoGetWithToken:(NSString *)access_token respon:(void (^)(SquadResponseModel *response))block;

-(void)profileEditWithData:(NSDictionary *)userEdited respon:(squadCompletion)response;

-(void)uploadImage:(NSData *)imageData userid:(NSString *)userid accessToken:(NSString *)accessToken respon:(squadCompletion)response;

-(void)tokenRefreshWithToken:(NSString *)refresh_token respon:(squadCompletion)response;
-(void)logoutAccessToken:(NSString *)access_token refreshToken:(NSString *)refresh_token respon:(squadCompletion)response;
-(void)resourceWithParamsGetWithToken:(NSString *)access_token respon:(squadCompletion)response;
-(void)emailVerifyWithUserid:(NSString *)user_id verificationCode:(NSString *)verification respon:(squadCompletion)response;
-(void)passwordForgotWithUserid:(NSString *)userid email:(NSString *)email verifyUrl:(NSString *)verifyUrl redirectUrl:(NSString *)redirecturl respon:(squadCompletion)response;
-(void)emailUpdateWithAccessToken:(NSString *)access_token userid:(NSString *)userid newEmail:(NSString *)newEmail password:(NSString *)password respon:(squadCompletion)response;
-(void)passwordCheckWithUserid:(NSString *)userid password:(NSString *)password respon:(squadCompletion)response;
-(void)registerVerificationResendWithUserid:(NSString *)userid respon:(squadCompletion)response;
-(void)verificationRegisterWithUserid:(NSString *)userid code:(NSString *)code redirect:(NSString *)redirectURI respon:(squadCompletion)response;
-(void)passwordUpdateWithAccessToken:(NSString *)accessToken userid:(NSString *)userid oldPassword:(NSString *)oldPass newPassword:(NSString *)newPass respon:(squadCompletion)response;
-(void)verificationRegisterResend:(NSString *)email respon:(squadCompletion)response;
-(void)getListCountry:(squadCompletion)response;
-(void)getListCityWithCountryId:(NSString *)countryID respon:(squadCompletion)response;

-(void)socialCheckFromFacebookWithAccessToken:(NSString *)access_token withUserId:(NSString *)userid respon:(squadCompletion)response;

-(void)socialLoginFromFacebookWithEmail:(NSString *)email withPassword:(NSString *)pass withUserId:(NSString *)userid withAccessToken:(NSString *)access_token respon:(squadCompletion)response;


-(void)socialLoginFromTwitterWithEmail:(NSString *)email withPassword:(NSString *)pass withUserId:(NSString *)userid withAccessToken:(NSString *)access_token withAcessTokenScret:(NSString *)token_secret withConsumerKey:(NSString *)consumer_key withConsumerSecret:(NSString *)consumer_secret respon:(squadCompletion)response;

-(void)socialCheckFromTwitterWithUserId:(NSString *)userid withAccessToken:(NSString *)access_token withAcessTokenScret:(NSString *)token_secret withConsumerKey:(NSString *)consumer_key withConsumerSecret:(NSString *)consumer_secret respon:(squadCompletion)response;

-(void)socialRegisterFrom:(NSString *)from withEmail:(NSString *)email withPassword:(NSString *)pass withUserId:(NSString *)userid withAccessToken:(NSString *)access_token withAcessTokenScret:(NSString *)token_secret withConsumerKey:(NSString *)consumer_key withConsumerSecret:(NSString *)consumer_secret firstName:(NSString *)firstname lastName:(NSString *)lastname companyid:(NSString *)comp_id redirecturi:(NSString *)red_uri verifyuri:(NSString *)ver_uri sendEmail:(bool)isSend completion:(squadCompletion)respon;

@end

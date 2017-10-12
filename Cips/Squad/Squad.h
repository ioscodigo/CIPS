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

@interface Squad : NSObject

@property (nonatomic,strong) NSString *clientID;
@property (nonatomic,strong) NSString *clientSecret;

-(instancetype)init __attribute__((unavailable("init not available")));

+(Squad *)instance;
+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret;
-(void)loginWithEmail:(NSString *)email andPassoword:(NSString *)password completion:(squadCompletion)respon;
-(void)registerFirstWithEmail:(NSString *)email password:(NSString *)password fullname:(NSString *)fullname companyid:(NSString *)comp_id redirecturi:(NSString *)red_uri verifyuri:(NSString *)ver_uri completion:(squadCompletion)respon;
-(void)userInfoGetWithToken:(NSString *)access_token respon:(void (^)(SquadResponseModel *response))block;

-(void)profileEditWithData:(NSDictionary *)userEdited respon:(squadCompletion)response;

-(void)uploadImageWithParam:(NSDictionary *)param respon:(squadCompletion)response;
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

@end

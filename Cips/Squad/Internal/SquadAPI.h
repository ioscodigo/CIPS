//
//  SquadAPI.h
//  Pods
//
//  Created by Fajar on 9/26/17.
//
//

#import <Foundation/Foundation.h>
#import <Cips/SquadResponseModel.h>
#import <Cips/CipsHTTPHelper.h>

typedef void (^squadCompletion)(SquadResponseModel *response);

@interface SquadAPI : NSObject
-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid withCompanyId:(NSString *)companyID;
-(void)setEnvironment:(ENVIRONMENT)env;

-(void)loginWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)registerWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)userInfoWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)editInfoWithParam:(NSDictionary *)param completion:(squadCompletion)block;

-(void)uploadImageWithParam:(NSDictionary *)param imageData:(NSData *)data completion:(squadCompletion)block;

-(void)refreshTokenWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)logoutWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)getUserInfoWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)verifyEmailWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)forgotPasswordWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)forgotPasswordStep2WithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)updateEmailWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)checkPasswordWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)resendRegistrationVerificationWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)registerVerificationWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)updatePasswordWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)resendVerificationRegisterWithParam:(NSDictionary *)param completion:(squadCompletion)block;
-(void)getListCountryWithCompletion:(squadCompletion)block;
-(void)getListCityWithCountryId:(NSString *)countryid completion:(squadCompletion)block;
@end

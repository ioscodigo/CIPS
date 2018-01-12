//
//  SquadAPI.m
//  Pods
//
//  Created by Fajar on 9/26/17.
//
//

#import "SquadAPI.h"
#import "SquadConstant.h"
//#import "Cips"

#define SQUAD_PROTOCOL                      @"http://"
#define SQUAD_BASE_PRODUCTION               (SQUAD_PROTOCOL @"api.squad.cips.stg.codigo.id/")
#define SQUAD_BASE_SANDBOX                  (SQUAD_PROTOCOL @"api.squad.cips.stg.codigo.id/")
#define SQUAD_BASE_DEVELOPMENT              (SQUAD_PROTOCOL @"api.squad.cips.dev.codigo.id/")

#define KEYCHAIN_SQUAD_IS_LOGIN @"SquadIsLogin"
#define KEYCHAIN_SQUAD_ACCESS_TOKEN @"SquadIsLogin"
#define KEYCHAIN_SQUAD_USER_ID @"SquadUserID"
#define KEYCHAIN_SQUAD_DATE_ACCESS_TOKEN @"SquadDateLogin"

@implementation SquadAPI

    NSString *BaseAPI;
    NSString *client_secret;
    NSString *client_id;
    CipsHTTPHelper *helper;
    KeychainWrapper *wrapper;
    NSString *company_id;

- (id)init
{
    return [self initWithSecretKey:@"" withClientid:@"" withCompanyId:@""];
}

-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid withCompanyId:(NSString *)companyID{
    self = [super init];
    if (self) {
        client_secret = clientSecret;
        client_id = clientid;
        helper = [CipsHTTPHelper instance];
        BaseAPI = SQUAD_BASE_DEVELOPMENT;
        wrapper = helper.keyChain;
        company_id = companyID;
    }
    return self;
}
-(void)postWithUrl:(NSString *)url withParam:(NSDictionary *)param withBlock:(squadCompletion)block{
    [self postWithUrl:url withHeader:nil withParam:param completion:block];
}

-(void)postWithUrl:(NSString *)url withHeader:(NSDictionary *)header withParam:(NSDictionary *)param completion:(squadCompletion)block{
    [helper requestFormDataWithMethod:POST WithUrl:[NSString stringWithFormat:@"%@%@",BaseAPI,url] withParameter:param withHeader:header withBlock:^(CipsHTTPResponse *respon) {
        SquadResponseModel *responSquad = [[SquadResponseModel alloc] init];
        responSquad.statusCode = respon.responseCode;
        if(respon.error){
            responSquad.isSucces = false;
            responSquad.error = respon.error;
            
        }else{
            responSquad.error = nil;
            responSquad.isSucces = true;
        }
        if(respon.data){
            responSquad.message = [respon.data objectForKey:@"message"];
            responSquad.display_message = [respon.data objectForKey:@"display_message"];
            responSquad.status = [respon.data objectForKey:@"status"];
            responSquad.data = [respon.data objectForKey:@"data"];
        }
        block(responSquad);
    }];
}

-(void)loginWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *parameter = [param mutableCopy];
    param = nil;
    [parameter addEntriesFromDictionary:@{
                                          @"client_id":client_id,
                                          @"client_secret":client_secret
                                          }];
    [self postWithUrl:SQUAD_LOGIN withParam:parameter withBlock:^(SquadResponseModel *response) {
        if(response.statusCode == 200){
            if(response.data && [response.data objectForKey:@"access_token"]){
#if !(TARGET_IPHONE_SIMULATOR)
                [wrapper mySetObject:[response.data objectForKey:@"access_token"] forKey:KEYCHAIN_SQUAD_ACCESS_TOKEN];
                [wrapper mySetObject:[NSString stringWithFormat:@"%f",[[[NSDate alloc] init] timeIntervalSince1970]] forKey:KEYCHAIN_SQUAD_DATE_ACCESS_TOKEN];
                
#endif
            }
        }
        block(response);
    }];
}


-(BOOL)SquadIsLogin{
    
    BOOL isLogin = [wrapper myObjectForKey:KEYCHAIN_SQUAD_IS_LOGIN] == [NSNull class] ? false : [wrapper myObjectForKey:KEYCHAIN_SQUAD_IS_LOGIN];
    return isLogin;
}

-(void)registerWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *parameter = [param mutableCopy];
    param = nil;
    [parameter addEntriesFromDictionary:@{
                                          @"client_id":client_id,
                                           @"company_id":company_id
                                          }];
    [self postWithUrl:SQUAD_REGISTER withParam:parameter withBlock:block];
}

-(void)userInfoWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    [self postWithUrl:SQUAD_USER_INFO withParam:param withBlock:block];
}


-(void)editInfoWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    [self postWithUrl:SQUAD_EDIT_USER withParam:param withBlock:block];
}

-(void)uploadImageWithParam:(NSDictionary *)param imageData:(NSData *)data completion:(squadCompletion)block{
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    // file
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: attachment; name=\"image_upload\"; filename=\"profile.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:data]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // text parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[param objectForKey:@"user_id"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // another text parameter
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"access_token\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[param objectForKey:@"access_token"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // close form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // set request body
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseAPI,SQUAD_UPLOAD_IMAGE]]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        SquadResponseModel *responSquad = [[SquadResponseModel alloc] init];
        responSquad.statusCode = [(NSHTTPURLResponse *)response statusCode];
        responSquad.error = error;
        responSquad.isSucces = false;
        if(!error){
//            NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSError *jsonError = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            responSquad.error = nil;
            responSquad.isSucces = true;
            if(jsonError){
                responSquad.error = jsonError;
                responSquad.isSucces = false;
                responSquad.display_message = @"Not JSON Format";
            }else{
                responSquad.message = [json objectForKey:@"message"];
                responSquad.display_message = [json objectForKey:@"display_message"];
                responSquad.status = [json objectForKey:@"status"];
                responSquad.data = [json objectForKey:@"data"];
            }
//            NSLog(@"responstr %@",responseStr);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(responSquad);
        });
        
    }] resume];

}

-(void)refreshTokenWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *parameter = [param mutableCopy];
    param = nil;
    [parameter addEntriesFromDictionary:@{
                                          @"client_id":client_id,
                                          @"client_secret":client_secret
                                          }];
    [self postWithUrl:SQUAD_REFRESH_TOKEN withParam:parameter withBlock:block];
}

-(void)logoutWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *paramater = [param mutableCopy];
    [paramater addEntriesFromDictionary:@{
                                          @"client_id":client_id,
                                          @"client_secret":client_secret
                                          }];
    [self postWithUrl:SQUAD_LOGOUT withParam:paramater withBlock:block];
}

-(void)getUserInfoWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    [self postWithUrl:SQUAD_USER_INFO_PARAM withParam:param withBlock:block];
}



//-(void)universalSearch:(NSDictionary *)param

-(void)verifyEmailWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *paramater = [param mutableCopy];
    [paramater addEntriesFromDictionary:@{
                                          @"client_id":client_id
                                          }];
    [self postWithUrl:SQUAD_VERIFY_EMAIL withParam:paramater withBlock:block];
}

-(void)forgotPasswordWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *paramater = [param mutableCopy];
    [paramater addEntriesFromDictionary:@{
                                          @"client_id":client_id
                                          }];
    [self postWithUrl:SQUAD_FORGOT_PASSWORD withParam:paramater withBlock:block];
}

-(void)forgotPasswordStep2WithParam:(NSDictionary *)param completion:(squadCompletion)block{
    [self postWithUrl:SQUAD_FORGOT_PASSWODR_STEP2 withParam:param withBlock:block];
}

-(void)updateEmailWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    [self postWithUrl:SQUAD_UPDATE_EMAIL withParam:param withBlock:block];
}

-(void)checkPasswordWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    [self postWithUrl:SQUAD_CHECK_PASSWORD withParam:param withBlock:block];
}

-(void)resendRegistrationVerificationWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *paramater = [param mutableCopy];
    [paramater addEntriesFromDictionary:@{
                                          @"client_id":client_id
                                          }];
    [self postWithUrl:SQUAD_RESEND_REG_VERIVICATION withParam:paramater withBlock:block];
}

-(void)registerVerificationWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *parameter = [param mutableCopy];
    [parameter addEntriesFromDictionary:@{
                                          @"client_id":client_id
                                          }];
    [self postWithUrl:SQUAD_REG_VERIVICATION withParam:parameter withBlock:block];
}

-(void)updatePasswordWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    [self postWithUrl:SQUAD_UPDATE_PASSWORD withParam:param withBlock:block];
}

-(void)resendVerificationRegisterWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    [self postWithUrl:SQUAD_RESEND_VER_REG withParam:param withBlock:block];
}

-(void)deleteUserWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    
}

-(void)getListCountryWithCompletion:(squadCompletion)block{
    NSDictionary *param = @{
                            @"company_id":company_id,
                            @"client_id":client_id
                            };
    [self postWithUrl:SQUAD_LIST_COUNTRY withParam:param withBlock:block];
}

-(void)getListCityWithCountryId:(NSString *)countryid completion:(squadCompletion)block{
    NSDictionary *param = @{
                            @"company_id":company_id,
                            @"client_id":client_id,
                            @"country_id":countryid
                            };
    [self postWithUrl:SQUAD_LIST_CITY withParam:param withBlock:block];
}

-(void)setEnvironment:(CIPSENVIRONMENT)env{
    switch (env) {
        case PRODUCTION:
            BaseAPI = SQUAD_BASE_DEVELOPMENT;
            break;
        case SANDBOX:
            BaseAPI = SQUAD_BASE_DEVELOPMENT;
            break;
        default:
            break;
    }
}

-(NSString *)getURL:(NSString *)str{
    return [NSString stringWithFormat:@"%@%@",BaseAPI,str];
}

@end



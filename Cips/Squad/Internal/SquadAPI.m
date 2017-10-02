//
//  SquadAPI.m
//  Pods
//
//  Created by Fajar on 9/26/17.
//
//

#import "SquadAPI.h"
#import "SquadConstant.h"

#define SQUAD_PROTOCOL                      @"http://"
#define SQUAD_BASE_PRODUCTION               (SQUAD_PROTOCOL @"api.squad2.stg.codigo.id/")
#define SQUAD_BASE_SANDBOX                  (SQUAD_PROTOCOL @"api.squad2.stg.codigo.id/")

//@interface SquadAPI()
//{
//    NSString *BaseAPI;
//    NSString *client_secret;
//    NSString *client_id;
//    CipsHTTPHelper *helper;
//    
//}

//@end

@implementation SquadAPI

    NSString *BaseAPI;
    NSString *client_secret;
    NSString *client_id;
    CipsHTTPHelper *helper;
    

- (id)init
{
    return [self initWithSecretKey:@"" withClientid:@""];
}

-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid{
    self = [super init];
    if (self) {
        client_secret = clientSecret;
        client_id = clientid;
        helper = [CipsHTTPHelper instance];
        BaseAPI = SQUAD_BASE_SANDBOX;
    }
    return self;
}
-(void)postWithUrl:(NSString *)url withParam:(NSDictionary *)param withBlock:(void (^)(SquadResponseModel *response))block{
    [self postWithUrl:url withHeader:nil withParam:param withBlock:block];
}

-(void)postWithUrl:(NSString *)url withHeader:(NSDictionary *)header withParam:(NSDictionary *)param completion:(squadCompletion)block{
    [helper requestMulitpartDataWithMethod:POST WithUrl:[NSString stringWithFormat:@"%@%@",BaseAPI,url] withParameter:param withHeader:header withBlock:^(CipsHTTPResponse *respon) {
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
    [self postWithUrl:SQUAD_LOGIN withParam:parameter withBlock:block];
}

-(void)registerWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *parameter = [param mutableCopy];
    param = nil;
    [parameter addEntriesFromDictionary:@{
                                          @"client_id":client_id
                                          }];
    [self postWithUrl:SQUAD_REGISTER withParam:parameter withBlock:block];
}

-(void)userInfoWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    [self postWithUrl:SQUAD_USER_INFO withParam:param withBlock:block];
}

-(void)refreshTokenWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *parameter = [param mutableCopy];
    param = nil;
    [parameter addEntriesFromDictionary:@{
                                          @"client_id":client_id,
                                          @"client_secret":client_secret
                                          }];
    [self postWithUrl:SQUAD_LOGIN withParam:parameter withBlock:block];
}

-(void)logutWithParam:(NSDictionary *)param completion:(squadCompletion)block{
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
    [self postWithUrl:SQUAD_VERIFY_EMAIL withParam:param withBlock:block];
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

-(void)resendRegistrationWithParam:(NSDictionary *)param completion:(squadCompletion)block{
    NSMutableDictionary *paramater = [param mutableCopy];
    [paramater addEntriesFromDictionary:@{
                                          @"client_id":client_id
                                          }];
    [self postWithUrl:SQUAD_RESEND_REG_VERIVICATION withParam:paramater withBlock:block];
}

-(void)setEnvironment:(ENVIRONMENT)env{
    switch (env) {
        case PRODUCTION:
            BaseAPI = SQUAD_BASE_PRODUCTION;
            break;
        case SANDBOX:
            BaseAPI = SQUAD_BASE_SANDBOX;
            break;
        default:
            break;
    }
}

-(NSString *)getURL:(NSString *)str{
    return [NSString stringWithFormat:@"%@%@",BaseAPI,str];
}

@end



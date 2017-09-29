//
//  SquadAPI.m
//  Pods
//
//  Created by Fajar on 9/26/17.
//
//

#import "SquadAPI.h"

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
    NSMutableDictionary *parameter = [param mutableCopy];
    param = nil;
    [helper requestMulitpartDataWithMethod:POST WithUrl:[NSString stringWithFormat:@"%@%@",BaseAPI,url] withParameter:parameter withHeader:header withBlock:^(CipsHTTPResponse *respon) {
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
    [helper requestFormDataWithMethod:POST WithUrl: withParameter:parameter withBlock:^(CipsHTTPResponse *response) {
        NSLog(@"%@",response.error);
        NSLog(@"%@",response.data);
    }];
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

@implementation NSString(Squad)

-(NSString *)env{
    return [NSString stringWithFormat:@"%@%@",BaseAPI,self];
}

@end


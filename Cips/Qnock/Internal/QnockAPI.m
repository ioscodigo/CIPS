//
//  QnockAPI.m
//  Pods
//
//  Created by Calista on 10/2/17.
//
//

#import "QnockAPI.h"

#define QNOCK_PROTOCOL                      @"http://"
#define QNOCK_BASE_PRODUCTION               (QNOCK_PROTOCOL @"push.qnock.netconnect.stg.codigo.id/")
#define QNOCK_BASE_SANDBOX                  (QNOCK_PROTOCOL @"push.qnock.netconnect.stg.codigo.id/")

@implementation QnockAPI
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
        BaseAPI = QNOCK_BASE_SANDBOX;
    }
    return self;
}

-(void)postWithUrl:(NSString *)url withParam:(NSDictionary *)param withBlock:(void (^)(QnockResponseModel *response))block{
    [self postWithUrl:url withHeader:nil withParam:param withBlock:block];
}

-(void)postWithUrl:(NSString *)url withHeader:(NSDictionary *)header withParam:(NSDictionary *)param completion:(qnockCompletion)block{
    NSMutableDictionary *parameter = [param mutableCopy];
    param = nil;
    [helper requestMulitpartDataWithMethod:POST WithUrl:[NSString stringWithFormat:@"%@%@",BaseAPI,url] withParameter:parameter withHeader:header withBlock:^(CipsHTTPResponse *respon) {
        QnockResponseModel *responQnock = [[QnockResponseModel alloc] init];
       // responSquad.statusCode = respon.responseCode;
        if(respon.error){
            responQnock.isSucces = false;
            responQnock.error = respon.error;
            
        }else{
            responQnock.error = nil;
            responQnock.isSucces = true;
        }
        if(respon.data){
            responQnock.message = [respon.data objectForKey:@"message"];
            responQnock.display_message = [respon.data objectForKey:@"display_message"];
            responQnock.status = [respon.data objectForKey:@"status"];
            //responSquad.data = [respon.data objectForKey:@"data"];
        }
        block(responQnock);
    }];
}


-(void)setEnvironment:(ENVIRONMENT)env{
    switch (env) {
        case PRODUCTION:
            BaseAPI = QNOCK_BASE_PRODUCTION;
            break;
        case SANDBOX:
            BaseAPI = QNOCK_BASE_SANDBOX;
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

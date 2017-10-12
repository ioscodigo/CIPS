//
//  QnockAPI.m
//  Pods
//
//  Created by Calista on 10/2/17.
//
//

#import "QnockAPI.h"
#import "QnockConstant.h"

#define QNOCK_PROTOCOL                      @"http://"
#define QNOCK_BASE_PRODUCTION               (QNOCK_PROTOCOL @"push.qnock.netconnect.stg.codigo.id/")
#define QNOCK_BASE_SANDBOX                  (QNOCK_PROTOCOL @"push.qnock.netconnect.stg.codigo.id/")

@implementation QnockAPI
    NSString *BaseAPI_qnock;
    NSString *client_secret_qnock;
    NSString *client_id_qnock;
    CipsHTTPHelper *helper_qnock;
    NSString *SecretQnock;
    NSString *authBase64Qnock;
    NSString *keyDateQnock = @"QNOCKDATE";
    NSString *keyAuthQnock = @"QNOCKAUTH";

- (id)init
{
    return [self initWithSecretKey:@"" withClientid:@"" completion:^(NSString *responseToken) {
        
    }];
}

-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid completion:(void (^)(NSString *responseToken))block{
    self = [super init];
    if (self) {
        client_secret_qnock = clientSecret;
        client_id_qnock = clientid;
        helper_qnock = [CipsHTTPHelper instance];
        BaseAPI_qnock = QNOCK_BASE_SANDBOX;
        _keyTokenQnock = @"QNOCKTOKEN";
        _tokenQnock = @"";
        NSString *client = [NSString stringWithFormat:@"%@:%@", clientid, clientSecret];
        NSData *data = [client dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *auth = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        authBase64Qnock = auth;
        
        if ([self isTokenAvailable]){
            _tokenQnock = [self getToken];
            block(_tokenQnock);
            [self checkStatus];
            
        }else{
            [self generateToken:^(NSString *responseToken) {
                 [self checkStatus];
                block(responseToken);
            }];
           
        }
        
       
    }
    return self;
}

-(void)qnockPostWithUrl:(NSString *)url withParam:(NSDictionary *)param withBlock:(void (^)(QnockResponseModel *response))block{
    NSDictionary *header = @{
                             @"Authorization" : [NSString stringWithFormat:@"Basic %@", authBase64Qnock]};
    NSLog(@"params %@", header);
    [self qnockPostWithUrl:url withHeader:header withParam:nil completion:block];
}

-(void)qnockPostWithUrl:(NSString *)url withHeader:(NSDictionary *)header withParam:(NSDictionary *)param completion:(qnockCompletion)block{
    NSMutableDictionary *parameter = [param mutableCopy];
    param = nil;
    [helper_qnock requestFormDataWithMethod:POST WithUrl:[NSString stringWithFormat:@"%@%@",BaseAPI_qnock,url] withParameter:parameter withHeader:header withBlock:^(CipsHTTPResponse *respon) {
        QnockResponseModel *responQnock = [[QnockResponseModel alloc] init];
        NSLog(@"respon %@",respon.responString);
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
        }
        block(responQnock);

    }];
//    [helper_qnock requestMulitpartDataWithMethod:POST WithUrl:[NSString stringWithFormat:@"%@%@",BaseAPI_qnock,url] withParameter:parameter withHeader:header withBlock:^(CipsHTTPResponse *respon) {
//        QnockResponseModel *responQnock = [[QnockResponseModel alloc] init];
//        if(respon.error){
//            responQnock.isSucces = false;
//            responQnock.error = respon.error;
//            
//        }else{
//            responQnock.error = nil;
//            responQnock.isSucces = true;
//        }
//        if(respon.data){
//            responQnock.message = [respon.data objectForKey:@"message"];
//            responQnock.display_message = [respon.data objectForKey:@"display_message"];
//            responQnock.status = [respon.data objectForKey:@"status"];
//        }
//        block(responQnock);
//    }];
}

-(void)checkStatus {
    NSDictionary *param = @{@"token" : _tokenQnock,
                            @"app_secret": SecretQnock};
    [self qnockPostWithUrl:QNOCK_STATUS withParam:param withBlock:^(QnockResponseModel *response) {
        if ([response.status  isEqual: @"SUCCES"]){
            NSLog(@"Qnock : Ready to use");
        }else{
            NSLog(@"Qnock : Failed, App not found");
        }
    }];
}

-(void) sendImpresition: (NSString *)unix_id {
    NSDictionary *param = @{@"token": _tokenQnock,
                            @"unix_id" : unix_id,
                            @"app_secret": SecretQnock};
    [self qnockPostWithUrl:QNOCK_IMPRESITION withParam:param withBlock:^(QnockResponseModel *response) {
        NSLog(@"Qnock : Success sent impresition");
       
    }];
}


-(void)saveToken {
    NSDate *date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:authBase64Qnock forKey:_keyTokenQnock];
    [[NSUserDefaults standardUserDefaults] setObject:_tokenQnock forKey:_keyTokenQnock];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:keyDateQnock];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setEnvironment:(ENVIRONMENT)env{
    switch (env) {
        case PRODUCTION:
            BaseAPI_qnock = QNOCK_BASE_PRODUCTION;
            break;
        case SANDBOX:
            BaseAPI_qnock = QNOCK_BASE_SANDBOX;
            break;
        default:
            break;
    }
}

- (BOOL)isTokenAvailable {
    NSString *temp = [[NSUserDefaults standardUserDefaults] objectForKey:_keyTokenQnock];
    NSString *t;
    NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:keyAuthQnock];
    
    
    if (t == temp){
        if (![t  isEqual: @""]) {
            if (![auth  isEqual: @""] && auth == authBase64Qnock){
                NSString *date = [[NSUserDefaults standardUserDefaults] objectForKey:keyDateQnock];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                NSDate *d;
                NSDate *dd = [dateFormat dateFromString:date];
                if ((d = dd)){
                    NSDate *curDate;
                    return [curDate compare:d] == NSOrderedDescending;
                }
                
            }
        }
    }
    return NO;
}

-(NSString *) getToken {
    if (![self isTokenAvailable]){
        return @"";
    }
    NSString *temp = [[NSUserDefaults standardUserDefaults] objectForKey:_keyTokenQnock];
    NSString *t;
    if ([t isEqualToString:temp]){
        return t;
    }
    
    return @"";
}


-(void)generateToken: (void (^)(NSString *responseToken))block{
    [self qnockPostWithUrl:QNOCK_TOKEN withParam:nil withBlock:^(QnockResponseModel *response) {
        if ([response.message isEqualToString:@"Success"]){
            NSLog(@"Qnock : Success get token");
            _tokenQnock = response.display_message;
            [self saveToken];
            block(_tokenQnock);
        }else{
            NSLog(@"Qnock : Fail %@", response.display_message);
        }
    }];
}

-(void) subscribe: (NSDictionary *)param completion:(qnockCompletion)block{
    [self qnockPostWithUrl:QNOCK_SUBSCRIBE withParam:param withBlock:block];
  }

-(void) unsubscribe: (NSDictionary *)param completion:(qnockCompletion)block{
    [self qnockPostWithUrl:QNOCK_UNSUBSCRIBE withParam:param withBlock:block];
}
/*
open func received(_ userinfo:[AnyHashable: Any])->AnyObject?{
    if let unix_id = userinfo["unix_id"] as? String{
        sendImpresition(unix_id)
        let data = userinfo["data"]
        return data as AnyObject?
    }
    return nil
}
*/

-(id) recevied: (NSDictionary *) userinfo {
    NSString *unix_id;
    if (unix_id == userinfo[@"unix_id"]) {
        [self sendImpresition:unix_id];
        NSData *data = userinfo[@"data"];
        return data;
    }
    return nil;
  
    
    
}

@end

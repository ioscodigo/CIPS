//
//  QnockAPI.m
//  Pods
//
//  Created by Calista on 10/2/17.
//
//

#import "QnockAPI.h"
#import "QnockConstant.h"

#define QNOCK_PROTOCOL                      @"https://"

#define QNOCK_BASE_PRODUCTION               (QNOCK_PROTOCOL @"api.qnock.id")
#define QNOCK_BASE_SANDBOX                  (QNOCK_PROTOCOL @"api.sandbox.qnock.id")


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
    return [[QnockAPI alloc] initWithSecretKey:clientSecret withClientid:clientid withEnvironment:PRODUCTION completion:block];
}

-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid withEnvironment:(CIPSENVIRONMENT)env completion:(void (^)(NSString *responseToken))block{
    self = [super init];
    if (self) {
        client_secret_qnock = clientSecret;
        client_id_qnock = clientid;
        helper_qnock = [CipsHTTPHelper instance];
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
//    NSLog(@"params %@", header);
    [self qnockPostWithUrl:url withHeader:header withParam:param completion:block];
}

-(void)qnockPostWithUrl:(NSString *)url withHeader:(NSDictionary *)header withParam:(NSDictionary *)param completion:(qnockCompletion)block{
//    param = nil;
    [helper_qnock requestJSONWithMethod:POST WithUrl:[NSString stringWithFormat:@"%@%@",BaseAPI_qnock,url] withParameter:param withHeader:header withBlock:^(CipsHTTPResponse *respon) {
//        NSLog(@"QNOCK response %@",respon.responString);
        QnockResponseModel *responQnock = [[QnockResponseModel alloc] init];
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
}


-(void)checkStatus {
    NSDictionary *param = @{@"token" : _tokenQnock,
                            @"app_secret": client_secret_qnock};
    [self qnockPostWithUrl:QNOCK_STATUS withParam:param withBlock:^(QnockResponseModel *response) {
        if ([[response.message lowercaseString] isEqualToString:@"success"]){
            NSLog(@"Qnock : Ready to use");
        }else{
            NSLog(@"Qnock : Failed, App not found");
        }
    }];
}

-(void) sendImpresition: (NSString *)unix_id {
    NSDictionary *param = @{@"token": _tokenQnock,
                            @"unix_id" : unix_id,
                            @"app_secret": client_secret_qnock};
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

-(void)setEnvironment:(CIPSENVIRONMENT)env onComplete:(void (^)(NSString *responseToken))block{
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
    [self generateToken:^(NSString *responseToken) {
        [self checkStatus];
        if(block){
            block(responseToken);
        }
    }];
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
    NSDictionary *header = @{
                             @"Authorization" : [NSString stringWithFormat:@"Basic %@", authBase64Qnock]};
    [helper_qnock requestFormDataWithMethod:POST WithUrl:[NSString stringWithFormat:@"%@%@",BaseAPI_qnock,QNOCK_TOKEN] withParameter:nil withHeader:header withBlock:^(CipsHTTPResponse *respon) {
//        NSLog(@"QNOCK response %@",respon.responString);
        QnockResponseModel *responQnock = [[QnockResponseModel alloc] init];
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
            responQnock.data = [respon.data objectForKey:@"data"];
        }
        if ([responQnock.message isEqualToString:@"Success"]){
            NSLog(@"Qnock : Success get token");
            _tokenQnock = [responQnock.data objectForKey:@"token"];
            [self saveToken];
            block(_tokenQnock);
        }else{
            NSLog(@"Qnock : Fail %@", responQnock.display_message);
        }
    }];
}

-(void) subscribe: (NSDictionary *)param completion:(qnockCompletion)block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:param];
    [params addEntriesFromDictionary:@{
                                       @"token": _tokenQnock,
                                       @"app_secret": client_secret_qnock
                                       }];
    [self qnockPostWithUrl:QNOCK_SUBSCRIBE withParam:params withBlock:block];
  }

-(void) unsubscribe: (NSDictionary *)param completion:(qnockCompletion)block{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:param];
    [params addEntriesFromDictionary:@{
                                       @"token": _tokenQnock,
                                       @"app_secret": client_secret_qnock
                                       }];
    [self qnockPostWithUrl:QNOCK_UNSUBSCRIBE withParam:params withBlock:block];
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
    NSString *unix_id = userinfo[@"unix_id"];
    if (unix_id){
        [self sendImpresition:unix_id];
        id data = userinfo[@"data"];
        return data;
    }
    return nil;
}

@end

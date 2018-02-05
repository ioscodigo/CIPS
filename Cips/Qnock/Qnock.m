//
//  Qnock.m
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import "Qnock.h"
#import "Internal/QnockAPI.h"
#import "QnockConstant.h"

@implementation Qnock

QnockAPI *apiQnock;
static Qnock *objQnock = nil;


+(Qnock*)instance
{
    @synchronized([Qnock class])
    {
        if (!objQnock)
            NSAssert(false,@"Instance not available, please init with clientid and client secret");
        
        return objQnock;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([Qnock class])
    {
        NSAssert(objQnock == nil, @"Attempted to allocate a second instance of a singleton.");
        objQnock = [super alloc];
        return objQnock;
    }
    
    return nil;
}

-(id)init {
    return nil;
}

-(id)initWithID:(NSString *)clientid secret:(NSString *)clientSecret{
    [Qnock alloc];
    if (self != nil) {
        apiQnock = [[QnockAPI alloc] initWithSecretKey:clientSecret withClientid:clientid completion:^(NSString *responseToken) {
            
        }];
    }
    return self;
}

+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret completion:(void (^)(NSString *responseToken))block{
    [Qnock alloc];
    objQnock.qnock_environment = PRODUCTION;
    apiQnock = [[QnockAPI alloc] initWithSecretKey:clientSecret withClientid:clientID completion:^(NSString *responseToken) {
        block(responseToken);
    }];
}


+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret withEnvironment:(CIPSENVIRONMENT)env completion:(void (^)(NSString *responseToken))block{
    [Qnock alloc];
    objQnock.qnock_environment = env;
    apiQnock = [[QnockAPI alloc] initWithSecretKey:clientSecret withClientid:clientID withEnvironment:env completion:^(NSString *responseToken) {
        block(responseToken);
    }];
}


-(void)setEnvironment:(CIPSENVIRONMENT)env onComplete:(void (^)(NSString *responseToken))block {
    self.qnock_environment = env;
    [apiQnock setEnvironment:env onComplete:block];
}

-(void)unsubscribe:(NSString *)FCMtoken withChannel: (NSString *) channel completion:(qnockCompletion)respon{
    NSDictionary *param = @{@"user_token_id" : FCMtoken,
                            @"channel" : channel,
                            @"device" : @"Iphone"
                            };
    
    [apiQnock unsubscribe:param completion:respon];
}

-(void)subscribe:(NSString *)FCMToken withChannel: (NSString *)channel userID: (NSString *)userID completion:(qnockCompletion)respon{
    NSDictionary *param = @{@"user_token_id": FCMToken,
                            @"channel" : channel,
                            @"device" : @"Iphone",
                            @"user_id" : userID
                            };
    [apiQnock subscribe:param completion: respon];
}

-(id)notifReceived:(NSDictionary *)userinfo{
    return [apiQnock recevied:userinfo];
}



@end

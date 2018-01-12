//
//  ;
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import <Foundation/Foundation.h>
#import "Cips/CipsHTTPHelper.h"
#import "QnockResponseModel.h"

typedef void (^qnockCompletion)(QnockResponseModel *response);

@interface Qnock : NSObject

@property (nonatomic,strong) NSString *clientID;
@property (nonatomic,strong) NSString *clientSecret;
@property (nonatomic) CIPSENVIRONMENT qnock_environment;

-(instancetype)init __attribute__((unavailable("init not available")));

+(Qnock *)instance;
+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret completion:(void (^)(NSString *responseToken))block;
+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret withEnvironment:(CIPSENVIRONMENT)env completion:(void (^)(NSString *responseToken))block;
-(void)setEnvironment:(CIPSENVIRONMENT)env onComplete:(void (^)(NSString *responseToken))block;
-(void)subscribe:(NSString *)FCMToken withChannel: (NSString *)channel userID: (NSString *)userID completion:(qnockCompletion)respon;
-(void)unsubscribe:(NSString *)FCMtoken withChannel: (NSString *) channel completion:(qnockCompletion)respon;
-(id)notifReceived:(NSDictionary *)userinfo;


@end

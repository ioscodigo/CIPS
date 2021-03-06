//
//  QnockAPI.h
//  Pods
//
//  Created by Calista on 10/2/17.
//
//

#import <Foundation/Foundation.h>
#import <Cips/QnockResponseModel.h>
#import <Cips/CipsHTTPHelper.h>

typedef void (^qnockCompletion)(QnockResponseModel *response);
 
@interface QnockAPI : NSObject

@property (nonatomic, strong) NSString *tokenQnock;
@property (nonatomic, strong) NSString *keyTokenQnock;

-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid completion:(void (^)(NSString *responseToken))block;
-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid withEnvironment:(CIPSENVIRONMENT)env completion:(void (^)(NSString *responseToken))block;
-(void)setEnvironment:(CIPSENVIRONMENT)env onComplete: (void (^)(NSString *responseToken))block;
-(void) subscribe: (NSDictionary *)param completion:(qnockCompletion)block;
-(void) unsubscribe: (NSDictionary *)param completion:(qnockCompletion)block;
-(id) recevied: (NSDictionary *) userinfo;
@end

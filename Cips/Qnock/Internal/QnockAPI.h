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
-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid;

-(void)postWithUrl:(NSString *)url withHeader:(NSDictionary *)header withParam:(NSDictionary *)param withBlock:(void (^)(QnockResponseModel *response))block;
-(void)postWithUrl:(NSString *)url withParam:(NSDictionary *)param withBlock:(void (^)(QnockResponseModel *response))block;
-(void)setEnvironment:(ENVIRONMENT)env;

-(void)loginWithParam:(NSDictionary *)param completion:(qnockCompletion)block;



@end

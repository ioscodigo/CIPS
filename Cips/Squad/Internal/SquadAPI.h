//
//  SquadAPI.h
//  Pods
//
//  Created by Fajar on 9/26/17.
//
//

#import <Foundation/Foundation.h>
#import <Cips/SquadResponseModel.h>
#import <Cips/CipsHTTPHelper.h>

@interface SquadAPI : NSObject
-(id)initWithSecretKey:(NSString *)clientSecret withClientid:(NSString*)clientid;

-(void)postWithUrl:(NSString *)url withHeader:(NSDictionary *)header withParam:(NSDictionary *)param withBlock:(void (^)(SquadResponseModel *response))block;
-(void)postWithUrl:(NSString *)url withParam:(NSDictionary *)param withBlock:(void (^)(SquadResponseModel *response))block;
-(void)setEnvironment:(ENVIRONMENT)env;
@end

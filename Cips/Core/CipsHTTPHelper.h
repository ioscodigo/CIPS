//
//  HTTPHelper.h
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import <Foundation/Foundation.h>
#import "CipsHTTPResponse.h"
#import "KeychainWrapper.h"

typedef enum {
    GET,
    POST,
    PUT,
    DELETE
} HTTPMethod;

typedef enum {
    PRODUCTION,
    SANDBOX
} ENVIRONMENT;

@interface CipsHTTPHelper : NSObject

@property(nonatomic,strong) KeychainWrapper *keyChain;

+(CipsHTTPHelper *)instance;

-(void)requestMulitpartDataWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withBlock:(void (^)(CipsHTTPResponse *response))block;
-(void)requestMulitpartDataWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withHeader:(NSDictionary *)headers withBlock:(void (^)(CipsHTTPResponse *response))block;

-(void)requestFormDataWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withBlock:(void (^)(CipsHTTPResponse *response))block;
-(void)requestFormDataWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withHeader:(NSDictionary *)headers withBlock:(void (^)(CipsHTTPResponse *response))block;

-(void)request:(HTTPMethod)method withURL:(NSString *)URL withBlock:(void (^)(CipsHTTPResponse *response))block;
-(void)request:(HTTPMethod)method withURL:(NSString *)URL withHeaders:(NSDictionary *)header withBlock:(void (^)(CipsHTTPResponse *response))block;
-(void)request:(HTTPMethod)method withURL:(NSString *)URL withBody:(NSData *)body withBlock:(void (^)(CipsHTTPResponse *response))block;
-(void)request:(HTTPMethod)method withURL:(NSString *)URL withBody:(NSData *)body withHeaders:(NSDictionary *)header withBlock:(void (^)(CipsHTTPResponse *response))block;

-(void)requestJSONWithMethod:(HTTPMethod)method WithUrl:(NSString *)url withParameter:(NSDictionary *)param withHeader:(NSDictionary *)headers withBlock:(void (^)(CipsHTTPResponse *response))block;



@end

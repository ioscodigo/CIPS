//
//  SquadViewHelper.h
//  Pods
//
//  Created by Fajar on 10/12/17.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    SUCCESS,
    ERROR,
    WARNING
} STATUS_VIEW;

@protocol SquadControllerDelegate<NSObject>

@optional
-(void)squadLoginResponse:(NSDictionary *)data status:(BOOL)isSuccees message:(NSString *)message controller:(UIViewController *)controller;

@optional
-(void)squadRegisterResponse:(NSDictionary *)data status:(BOOL)isSuccess message:(NSString *)message controller:(UIViewController *)controller;

@optional
-(void)LoginWithTwitter:(void (^)(NSString *access_token, NSString *secret_token, NSString *consumer_key, NSString *consumer_secret, NSString *userid))complete;

@end

@interface SquadViewHelper : NSObject

@property (nonatomic,strong) UIStoryboard *storyboard;




-(void)addLoading;
-(void)removeLoading;

+(SquadViewHelper *)helper;
+(void)SquadLoginViewWithController:(UIViewController *)controller withRedirectURL:(NSString *)redirect withVerifyURL:(NSString *)verify autoVerifyRegister:(bool)autoVerify delegate:(id<SquadControllerDelegate>)delegate;
+(void)SquadProfileViewWithController:(UIViewController *)controller token:(NSString *)access_token;
-(void)showMessage:(NSString *)msg status:(STATUS_VIEW)status;

@end

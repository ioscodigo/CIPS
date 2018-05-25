//
//  SquadForgotPasswordViewController.h
//  Pods
//
//  Created by Fajar on 10/26/17.
//
//

#import <UIKit/UIKit.h>

@interface SquadForgotPasswordViewController : UIViewController

@property (weak, nonatomic) NSString *accessToken;
@property (weak, nonatomic) NSString *userID;

@property (strong, nonatomic) NSString *redirectURI;
@property (strong, nonatomic) NSString *verifyURI;

@end

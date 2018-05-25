//
//  SquadRegisterViewController.h
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import <UIKit/UIKit.h>
#import "../SquadViewHelper.h"

@interface SquadRegisterViewController : UIViewController

@property (nonatomic) id<SquadControllerDelegate> delegate;

@property (nonatomic) bool fromSocial;
@property (nonatomic) bool fromFacebook;
@property (strong, nonatomic) NSDictionary *socialParam;

@property (strong, nonatomic) NSString *redirectURI;
@property (strong, nonatomic) NSString *verifyURI;
@property (nonatomic) bool isAutoVerifyRegister;


@property (weak, nonatomic) IBOutlet UITextField *fiedlFirstName;
@property (weak, nonatomic) IBOutlet UITextField *fieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *fieldConfirmPassword;

@end

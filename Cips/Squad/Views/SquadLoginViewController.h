//
//  SquadLoginViewController.h
//  Pods
//
//  Created by Fajar on 10/17/17.
//
//

#import <UIKit/UIKit.h>
#import "../SquadViewHelper.h"


@interface SquadLoginViewController : UIViewController

@property (nonatomic) id<SquadControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UIView *viewHolderSocial;
@property (strong, nonatomic) NSString *redirectURI;
@property (strong, nonatomic) NSString *verifyURI;
@property (nonatomic) bool isAutoVerifyRegister;

@end

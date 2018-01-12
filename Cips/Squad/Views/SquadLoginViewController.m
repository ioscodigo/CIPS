//
//  SquadLoginViewController.m
//  Pods
//
//  Created by Fajar on 10/17/17.
//
//

#import "SquadLoginViewController.h"
#import "Cips/Cips.h"
#import "SquadRegisterViewController.h"
#import "SquadForgotPasswordViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface SquadLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imagePassword;

@end

@implementation SquadLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _fieldEmail.delegate = self;
    _fieldPassword.delegate = self;
}


-(void)viewWillAppear:(BOOL)animated{
    _fieldEmail.text = @"testsdk2@mailhog.codigo.id";
    _fieldPassword.text = @"Test1234";
}

- (IBAction)forgotPassword:(id)sender {
    SquadForgotPasswordViewController *forgot =  [self.storyboard instantiateViewControllerWithIdentifier:@"forgotVC"];
    [self.navigationController pushViewController:forgot animated:true];
}

- (IBAction)signInOnClick:(id)sender {
    NSString *userEmail = self.fieldEmail.text;
    NSString *userPassword = self.fieldPassword.text;
    SquadViewHelper *helper = [SquadViewHelper helper];
    [helper addLoading];
    [Squad.instance loginWithEmail:userEmail andPassoword:userPassword completion:^(SquadResponseModel *response) {
        [helper removeLoading];
        if([response.status isEqualToString:@"200"]){
            [helper showMessage:response.display_message status:SUCCESS];
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
        if(_delegate){
            [_delegate squadLoginResponse:response.data status:[response.status isEqual: @"200"] message:response.display_message controller:self];
        }
    }];
}
- (IBAction)changePassword:(id)sender {
    _imagePassword.highlighted = !_imagePassword.isHighlighted;
    _fieldPassword.secureTextEntry = !_imagePassword.isHighlighted;
}

- (IBAction)registerOnClick:(id)sender {
    SquadViewHelper *helper = [SquadViewHelper helper];
    SquadRegisterViewController *reg = [helper.storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
    reg.delegate = _delegate;
    [self.navigationController pushViewController:reg animated:true];
}
- (IBAction)siginSocialLogin:(UIButton *)sender {
}

-(void)facebookLogin{
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
    [manager logInWithReadPermissions:@[@"public_profile",@"user_email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            
    }];
}

- (IBAction)dismisLoginViewController:(id)sender {
    if(_delegate){
        [_delegate squadLoginResponse:nil status:false message:@"Canceled" controller:self];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == _fieldEmail){
        [_fieldPassword becomeFirstResponder];
    }
    if(textField == _fieldPassword){
        [textField endEditing:true];
    }
    return true;
}


@end

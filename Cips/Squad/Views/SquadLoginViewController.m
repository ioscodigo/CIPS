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

#if __has_include("../SquadSocial.h")
#import "../SquadSocial.h"
#endif
#if __has_include(<FBSDKLoginKit/FBSDKLoginKit.h>)
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#endif

@interface SquadLoginViewController ()<UITextFieldDelegate>{
    bool withSocial;
    NSDictionary *socialParam;
    bool fromFacebook;
}

@property (weak, nonatomic) IBOutlet UIImageView *imagePassword;
@property (weak, nonatomic) IBOutlet UIView *viewFacebook;
@property (weak, nonatomic) IBOutlet UIView *viewTwitter;
@property (weak, nonatomic) IBOutlet UIView *viewGoogle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightHolderSocial;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHolderSocial;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthViewFacebook;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthViewTwitter;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *spaceRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthViewGoogle;

@end

@implementation SquadLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _fieldEmail.delegate = self;
    _fieldPassword.delegate = self;
    _widthViewGoogle.constant = 0;
    [_viewGoogle setHidden:true];
    _spaceRight.constant = 0;
    withSocial = false;
    Class fbClass = NSClassFromString(@"FBSDKLoginManager");
    bool hasTwitter = (_delegate != nil && [_delegate respondsToSelector:@selector(LoginWithTwitter:)]);
    if ((fbClass != nil || hasTwitter) && false){
        [_viewHolderSocial setHidden:false];
        if(fbClass){
            NSLog(@"HAS CLASS");
            [_viewFacebook setHidden:false];
        }else{
            NSLog(@"HASNT CLASS");
            [_viewFacebook setHidden:true];
            _widthViewFacebook.constant = 0;
            _spaceLeft.constant = 0;
        }
        if(hasTwitter){
            [_viewTwitter setHidden:false];
        }else{
            [_viewTwitter setHidden:true];
            _widthViewTwitter.constant = 0;
            _spaceLeft.constant = 0;
        }
    }else{
        _heightHolderSocial.constant = 0;
        _bottomHolderSocial.constant -= 40;
    }
}

- (IBAction)forgotPassword:(id)sender {
    SquadForgotPasswordViewController *forgot =  [self.storyboard instantiateViewControllerWithIdentifier:@"forgotVC"];
    forgot.redirectURI = self.redirectURI;
    forgot.verifyURI = self.verifyURI;
//    forgot.isa
    [self.navigationController pushViewController:forgot animated:true];
}

- (IBAction)signInOnClick:(id)sender {
    NSString *userEmail = self.fieldEmail.text;
    NSString *userPassword = self.fieldPassword.text;
    SquadViewHelper *helper = [SquadViewHelper helper];
    [helper addLoading];
    if (withSocial) {
        if(fromFacebook) {
            [Squad.instance socialLoginFromFacebookWithEmail:userEmail withPassword:userPassword withUserId:[socialParam valueForKey:@"userid"] withAccessToken:[socialParam valueForKey:@"token"] respon:^(SquadResponseModel *response) {
                [helper removeLoading];
                [self loginRespons:response];
            }];
        }else{
            [Squad.instance socialLoginFromTwitterWithEmail:userEmail withPassword:userPassword withUserId:[socialParam valueForKey:@"userid"] withAccessToken:[socialParam valueForKey:@"token"] withAcessTokenScret:[socialParam valueForKey:@"secret"] withConsumerKey:[socialParam valueForKey:@"token_consumer"] withConsumerSecret:[socialParam valueForKey:@"secret_consumer"] respon:^(SquadResponseModel *response) {
                [helper removeLoading];
                [self loginRespons:response];
            }];
        }
    }else{
    [Squad.instance loginWithEmail:userEmail andPassword:userPassword completion:^(SquadResponseModel *response) {
        [helper removeLoading];
        [self loginRespons:response];
    }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.fieldEmail.text = @"iossdk@mailhog.codigo.id";
    self.fieldPassword.text = @"Test4321";
}

-(void)loginRespons:(SquadResponseModel *)response{
    SquadViewHelper *helper = [SquadViewHelper helper];
    if([response.status isEqualToString:@"200"]){
        [helper showMessage:response.display_message status:SUCCESS];
    }else{
        [helper showMessage:response.display_message status:ERROR];
    }
    if(_delegate){
        [_delegate squadLoginResponse:response.data status:[response.status isEqual: @"200"] message:response.display_message controller:self];
    }
}

- (IBAction)changePassword:(id)sender {
    _imagePassword.highlighted = !_imagePassword.isHighlighted;
    _fieldPassword.secureTextEntry = !_imagePassword.isHighlighted;
}

- (IBAction)registerOnClick:(id)sender {
    SquadViewHelper *helper = [SquadViewHelper helper];
    SquadRegisterViewController *reg = [helper.storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
    reg.delegate = _delegate;
    reg.verifyURI = self.verifyURI;
    reg.redirectURI = self.redirectURI;
    reg.isAutoVerifyRegister = self.isAutoVerifyRegister;
    [self.navigationController pushViewController:reg animated:true];
}
- (IBAction)siginSocialLogin:(UIButton *)sender {
//    NSLog(@"Social Login %d",sender.tag);
    switch (sender.tag) {
        case 1:
            [self facebookLogin];
            break;
        case 2:
            [self twitterLogin];
            break;
        default:
            break;
    }
}

-(void)facebookLogin{
#if __has_include(<FBSDKLoginKit/FBSDKLoginKit.h>)
    
    SquadViewHelper *helper = [SquadViewHelper helper];
    if ([FBSDKAccessToken currentAccessToken]) {
        FBSDKAccessToken *token = [FBSDKAccessToken currentAccessToken];
        [helper addLoading];
        [Squad.instance socialCheckFromFacebookWithAccessToken:token.tokenString withUserId:token.userID respon:^(SquadResponseModel *response) {
            [helper removeLoading];
//            NSLog(@"Response %@",response.display_message);
//            NSLog(@"Response %@",response.message);
//            NSLog(@"Response %@",response.data);
//            NSLog(@"Response %d",response.statusCode);
            NSLog(@"Response %@",response.status);
            NSDictionary *param = @{
                            @"userid":token.userID,
                            @"token":token.tokenString,
                            @"secret":@"1",
                            @"token_consumer":@"1",
                            @"secret_consumer":@"1"
                            };
            [self responSocialWithRespon:response fromFB:true socialParam:param];
        }];
    }else{
        NSLog(@"NOT HAVE ACCESS TOKEN");
        FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
        [manager logInWithReadPermissions:@[@"public_profile",@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (!error){
            [helper addLoading];
            [Squad.instance socialCheckFromFacebookWithAccessToken:result.token.tokenString withUserId:result.token.userID respon:^(SquadResponseModel *response) {
                [helper removeLoading];
            }];
            }
        }];
    }
#endif
}


-(void)responSocialWithRespon:(SquadResponseModel *)response fromFB:(bool) fb socialParam:(NSDictionary *)param {
    SquadViewHelper *helper = [SquadViewHelper helper];
    if([response.status isEqualToString:@"200"]){
        [helper showMessage:response.display_message status:SUCCESS];
        if(_delegate){
            [_delegate squadLoginResponse:response.data status:[response.status isEqual: @"200"] message:response.display_message controller:self];
        }
    }else if([response.status isEqualToString:@"202"]){
        [helper showMessage:response.display_message status:SUCCESS];
        fromFacebook = fb;
        withSocial = true;
        socialParam = param;
        [self.fieldEmail setText:[response.data valueForKey:@"email"]];
        self.fieldEmail.enabled = false;
//        [self.fieldEmail setAllowsEditingTextAttributes:false];
    }else if([response.status isEqualToString:@"203"]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Email Not Found" message:@"Have squad account ?" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *login = [UIAlertAction actionWithTitle:@"Login" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [helper showMessage:response.display_message status:SUCCESS];
            fromFacebook = fb;
            withSocial = true;
            socialParam = param;
        }];
        UIAlertAction *reg = [UIAlertAction actionWithTitle:@"Register" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SquadRegisterViewController *reg = [helper.storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
            reg.fromFacebook = fb;
            reg.fromSocial = true;
            reg.socialParam = param;
            reg.delegate = _delegate;
            reg.redirectURI = self.redirectURI;
            reg.verifyURI = self.verifyURI;
            reg.isAutoVerifyRegister = self.isAutoVerifyRegister;
            [self.navigationController pushViewController:reg animated:true];
        }];
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:true completion:nil];
        }];
        [alert addAction:login];
        [alert addAction:reg];
        [alert addAction:dismiss];
        [self presentViewController:alert animated:true completion:nil];
    }else if([response.status isEqualToString:@"204"]){
        SquadRegisterViewController *reg = [helper.storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
        reg.fromFacebook = fb;
        reg.fromSocial = true;
        reg.socialParam = param;
        reg.delegate = _delegate;
        reg.redirectURI = self.redirectURI;
        reg.verifyURI = self.verifyURI;
        reg.isAutoVerifyRegister = self.isAutoVerifyRegister;
        [self.navigationController pushViewController:reg animated:true];
    }else{
        [helper showMessage:response.display_message status:ERROR];
    }
    
}

-(void)twitterLogin{
    
    if(_delegate){
        [_delegate LoginWithTwitter:^(NSString *access_token, NSString *secret_token, NSString *consumer_key, NSString *consumer_secret, NSString *userid) {
            SquadViewHelper *helper = [SquadViewHelper helper];
            [helper addLoading];
            NSLog(@"test tw");
            [Squad.instance socialCheckFromTwitterWithUserId:userid withAccessToken:access_token withAcessTokenScret:secret_token withConsumerKey:consumer_key withConsumerSecret:consumer_secret respon:^(SquadResponseModel *response) {
                [helper removeLoading];
//                            NSLog(@"Response %@",response.display_message);
//                            NSLog(@"Response %@",response.message);
//                            NSLog(@"Response %@",response.data);
//                            NSLog(@"Response %d",response.statusCode);
//                NSLog(@"Response %@",response.status);
                NSDictionary *param = @{
                                        @"userid":userid,
                                        @"token":access_token,
                                        @"secret":secret_token,
                                        @"token_consumer":consumer_key,
                                        @"secret_consumer":consumer_secret
                                        };
                [self responSocialWithRespon:response fromFB:false socialParam:param];
            }];
        }];
    }
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

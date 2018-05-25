//
//  TestingViewController.m
//  Chips
//
//  Created by Fajar on 12/4/17.
//  Copyright © 2017 fajaraw. All rights reserved.
//

#import "SquadTestingViewController.h"
#import <Cips/Cips.h>
#import <Cips/SquadViewHelper.h>
#import <TwitterKit/TWTRKit.h>

@interface SquadTestingViewController ()<SquadControllerDelegate,LoginWithTwitterDelegate>
{
    Squad *squad;
    SquadViewHelper *helper;
    NSString *accessToken;
    NSString *refreshToken;
    NSString *userid;
    BOOL firstSetup;
    bool autoVerify;
}

@end

@implementation SquadTestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    accessToken = @"a";
    refreshToken = @"a";
    userid = @"0";
    firstSetup = true;
//    [Squad initWithClientId:@"317124652832" withClientSecret:@"7256364256403152644230455e6e4370245833396b433571774c54393675306b44252a3a4d7564553774747650646d437368" withCompanyId:@"4"];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    if(firstSetup){
        firstSetup = false;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Environment" message:@"Please select environment" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"Auto Verify" message:@"Please select is send email or not while register" preferredStyle:UIAlertControllerStyleActionSheet];
    [Squad initWithClientId:@"BRANCH001" withClientSecret:@"3c516b727d7d67392e486d435731294b3e686e2f4e6636524d466b4265537b3f374b58254b3f67333e5a37395d515a26536b" withCompanyId:@"1" withEnvironment:PRODUCTION];
    squad = Squad.instance;
    helper = SquadViewHelper.helper;
    [alert addAction:[UIAlertAction actionWithTitle:@"PRODUCTION" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Squad initWithClientId:@"BRANCH001" withClientSecret:@"3c516b727d7d67392e486d435731294b3e686e2f4e6636524d466b4265537b3f374b58254b3f67333e5a37395d515a26536b" withCompanyId:@"1" withEnvironment:PRODUCTION];
        squad = Squad.instance;
        helper = SquadViewHelper.helper;
        [self presentViewController:alert2 animated:true completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"SANDBOX" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Squad initWithClientId:@"BRANCH001" withClientSecret:@"3c516b727d7d67392e486d435731294b3e686e2f4e6636524d466b4265537b3f374b58254b3f67333e5a37395d515a26536b" withCompanyId:@"1" withEnvironment:SANDBOX];
        squad = Squad.instance;
        helper = SquadViewHelper.helper;
        [self presentViewController:alert2 animated:true completion:nil];
    }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"Auto Verify/Not Send Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            autoVerify = true;
        }]];
        [alert2 addAction:[UIAlertAction actionWithTitle:@"Manual Verify / Send Email" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            autoVerify = false;
        }]];
        [self presentViewController:alert2 animated:true completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerEmailWithEmail:(NSString *)email{

}

- (IBAction)squadLoginOnClick:(id)sender {
    [SquadViewHelper SquadLoginViewWithController:self withRedirectURL:@"http://web.squad.dev.codigo.id/register" withVerifyURL:@"http://web.squad.dev.codigo.id/Register/verification" autoVerifyRegister:autoVerify delegate:self];
}

- (IBAction)squadViewProfileOnClick:(id)sender {
    [SquadViewHelper SquadProfileViewWithController:self token:accessToken];
}

- (IBAction)squadCheckTokenOnClick:(id)sender {
    [squad userInfoGetWithToken:accessToken respon:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            [helper showMessage:@"Access Token Valid" status:SUCCESS];
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
}

- (IBAction)squadRefreshTokenOnClick:(id)sender {
    [squad tokenRefreshWithToken:refreshToken respon:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            [helper showMessage:@"Sukses Refresh Token" status:SUCCESS];
            accessToken = [response.data objectForKey:@"access_token"];
            refreshToken = [response.data objectForKey:@"refresh_token"];
            NSLog(@"Access token %@",accessToken);
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
}

-(void)LoginWithTwitter:(void (^)(NSString *, NSString *, NSString *, NSString *, NSString *))complete{
    TWTRSession *twsession = [[[Twitter sharedInstance] sessionStore] session];
    TWTRAuthConfig *config = [[Twitter sharedInstance] authConfig];
//    if(twsession){
//        complete([twsession authToken],[twsession authTokenSecret],[config consumerKey],[config consumerSecret],[twsession userID]);
//    }else{
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
            NSLog(@"SIGNED %@",[session authTokenSecret]);
            NSLog(@"signed %@",session.userID);
            complete([session authToken],[session authTokenSecret],[config consumerKey],[config consumerSecret],[session userID]);
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
    }];
//    }
}

-(void)squadLoginResponse:(NSDictionary *)data status:(BOOL)isSuccees message:(NSString *)message controller:(UIViewController *)controller{
    [controller dismissViewControllerAnimated:true completion:nil];
    NSLog(@"Status %d, message: %@",isSuccees,message);
    if(isSuccees){
        accessToken = [data objectForKey:@"access_token"];
        refreshToken = [data objectForKey:@"refresh_token"];
        NSLog(@"Access token %@",accessToken);
//        [controller dismissViewControllerAnimated:true completion:nil];
    }
}



@end

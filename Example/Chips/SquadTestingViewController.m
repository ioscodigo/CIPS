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

@interface SquadTestingViewController ()<SquadControllerDelegate>
{
    Squad *squad;
    SquadViewHelper *helper;
    NSString *accessToken;
    NSString *refreshToken;
    NSString *userid;
}

@end

@implementation SquadTestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    accessToken = @"a";
    refreshToken = @"a";
    userid = @"0";
    [Squad initWithClientId:@"6b345e743f707b70283b29" withClientSecret:@"4473524f74692f3039796725693b45724834554e38716e38545024673347542179444d7034545e2e70367831523b525a3434" withCompanyId:@"11"];
    squad = Squad.instance;
    helper = SquadViewHelper.helper;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerEmailWithEmail:(NSString *)email{
    [squad registerFirstWithEmail:email password:@"Test1234" firstName:@"test1234" lastName:@"test" companyid:squad.companyID redirecturi:@"http://web.squad.dev.codigo.id/register" verifyuri:@"http://web.squad.dev.codigo.id/Register/verification" completion:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            [helper showMessage:@"Success! Please Check your email to activate your account" status:SUCCESS];
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
}
- (IBAction)squadLoginOnClick:(id)sender {
    [SquadViewHelper SquadLoginViewWithController:self delegate:self];
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

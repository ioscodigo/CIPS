//
//  SquadLoginViewController.m
//  Pods
//
//  Created by Fajar on 10/17/17.
//
//

#import "SquadLoginViewController.h"
#import "Cips/Cips.h"

@interface SquadLoginViewController ()

@end

@implementation SquadLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forgotPassword:(id)sender {
}
- (IBAction)signInOnClick:(id)sender {
    NSString *userEmail = self.fieldEmail.text;
    NSString *userPassword = self.fieldPassword.text;
    [Squad.instance loginWithEmail:userEmail andPassoword:userPassword completion:^(SquadResponseModel *response) {
        if([response.status isEqual: @"200"]){
            NSString *msg = response.display_message;
        }else{
            NSString *msg = response.display_message;
        }
    }];
}
- (IBAction)registerOnClick:(id)sender {
}
- (IBAction)siginSocialLogin:(UIButton *)sender {
}


@end

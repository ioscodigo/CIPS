//
//  QnockTestingViewController.m
//  Chips
//
//  Created by Fajar on 12/13/17.
//  Copyright © 2017 fajaraw. All rights reserved.
//

#import "QnockTestingViewController.h"
#import <Cips/Cips.h>
#import <FirebaseMessaging/FirebaseMessaging.h>


@interface QnockTestingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelENV;
@property (weak, nonatomic) IBOutlet UITextField *fieldChannelName;
@property (weak, nonatomic) IBOutlet UITextField *fieldPushChannel;
@property (weak, nonatomic) IBOutlet UITextField *fieldPushText;
@property (weak, nonatomic) IBOutlet UILabel *labelCode;

@end

@implementation QnockTestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    self.labelCode.text = FIRMessaging.messaging.FCMToken;
}

- (IBAction)subscribeOnClick:(id)sender {
//    [Qnock.instance subscribe:<#(NSString *)#> withChannel:<#(NSString *)#> userID:<#(NSString *)#> completion:<#^(QnockResponseModel *response)respon#>]
    NSLog(@"FCMTOKEN %@",FIRMessaging.messaging.FCMToken);
    [Qnock.instance subscribe:FIRMessaging.messaging.FCMToken withChannel:_fieldChannelName.text userID:@"0" completion:^(QnockResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:response.display_message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Dissmis" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:true completion:nil];
            }]];
            [self presentViewController:alert animated:true completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed" message:response.display_message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Dissmis" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:true completion:nil];
            }]];
            [self presentViewController:alert animated:true completion:nil];
        }
    }];
}

- (IBAction)unsubscribeOnClick:(id)sender {
    [Qnock.instance unsubscribe:FIRMessaging.messaging.FCMToken withChannel:_fieldChannelName.text completion:^(QnockResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:response.display_message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Dissmis" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:true completion:nil];
            }]];
            [self presentViewController:alert animated:true completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed" message:response.display_message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Dissmis" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:true completion:nil];
            }]];
            [self presentViewController:alert animated:true completion:nil];
        }
    }];
}

- (IBAction)sendPushOnClick:(id)sender {
    
}
- (IBAction)changeEnvironment:(UIButton *)sender {
    CIPSENVIRONMENT env = PRODUCTION;
    switch (Qnock.instance.qnock_environment) {
        case PRODUCTION:
            env = SANDBOX;
            [sender setTitle:@"Production" forState:UIControlStateNormal];
            _labelENV.text = @"Current Environment : Sandbox";
            break;
        case SANDBOX:
            env = PRODUCTION;
            [sender setTitle:@"Sandbox" forState:UIControlStateNormal];
            _labelENV.text = @"Current Environment : Production";
            break;
        default:
            break;
    }
    
    [Qnock.instance setEnvironment:env onComplete:^(NSString *responseToken) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success" message:@"Success Change Environment" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Dissmis" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:true completion:nil];
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }];
}

@end

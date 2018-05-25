//
//  SquadForgotPasswordViewController.m
//  Pods
//
//  Created by Fajar on 10/26/17.
//
//

#import "SquadForgotPasswordViewController.h"
#import "../SquadViewHelper.h"
#import "../Squad.h"
#import "PopupMessage.h"

@interface SquadForgotPasswordViewController ()<PopupMessageDelegate>
@property (weak, nonatomic) IBOutlet UITextField *fieldEmailAddress;

@end

@implementation SquadForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)sendRequstForgot:(id)sender {
    NSString *email = self.fieldEmailAddress.text;
    [Squad.instance passwordForgotWithUserid:@"" email:email verifyUrl:self.verifyURI redirectUrl:self.redirectURI respon:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            PopupMessage *msg = [[PopupMessage alloc] init];
            msg.delegate = self;
            [msg show:@"Please check your email to reset your password"];
        }else{
            [SquadViewHelper.helper showMessage:response.display_message status:ERROR];
        }
    }];
}

-(void)popupOnDismiss{
    [self.navigationController popViewControllerAnimated:true];
}

- (IBAction)exitOnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}


@end

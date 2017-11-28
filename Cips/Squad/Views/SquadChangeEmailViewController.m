//
//  SquadChangeEmailViewController.m
//  Pods
//
//  Created by Fajar on 11/8/17.
//
//

#import "SquadChangeEmailViewController.h"
#import "SquadCustomView+Keyboard.h"
#import "Cips/Cips.h"
#import "PopupMessage.h"
#import "../SquadViewHelper.h"

@interface SquadChangeEmailViewController ()<PopupMessageDelegate>{
    SquadCustomView_Keyboard *keyboardNotif;
}
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;
@property (weak, nonatomic) IBOutlet UIImageView *imagePassword;
@property (weak, nonatomic) IBOutlet UIView *viewKeyboard;



@end

@implementation SquadChangeEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    keyboardNotif = [SquadCustomView_Keyboard initWithView:_viewKeyboard  andController:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    [keyboardNotif removeNotif];
}

- (IBAction)passwordChange:(id)sender {
    _imagePassword.highlighted = !_imagePassword.isHighlighted;
    _fieldPassword.secureTextEntry = !_imagePassword.isHighlighted;
}
- (IBAction)updateEmailOnClick:(id)sender {
    [Squad.instance emailUpdateWithAccessToken:self.accessToken userid:self.userID newEmail:_fieldEmail.text password:_fieldPassword.text respon:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            PopupMessage *msg = [[PopupMessage alloc] init];
            msg.delegate = self;
            [msg show:response.display_message];
        }else{
            [SquadViewHelper.helper showMessage:response.display_message status:ERROR];
        }
    }];
}

-(void)popupOnDismiss{
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)backOnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end

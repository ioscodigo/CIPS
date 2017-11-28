//
//  SquadChangePasswordViewController.m
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import "SquadChangePasswordViewController.h"
#import <Cips/Cips.h>
#import "../SquadViewHelper.h"

@interface SquadChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fieldOldPass;
@property (weak, nonatomic) IBOutlet UITextField *fieldNewPass;
@property (weak, nonatomic) IBOutlet UITextField *fieldConfirmationPass;
@property (weak, nonatomic) IBOutlet UIImageView *imageShowPassOld;
@property (weak, nonatomic) IBOutlet UIImageView *imageShowPassNew;
@property (weak, nonatomic) IBOutlet UIView *viewKeyboard;

@end

@implementation SquadChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)toggleShowPassOld:(id)sender {
    _imageShowPassOld.highlighted = !_imageShowPassOld.isHighlighted;
    [_fieldOldPass setSecureTextEntry:!_imageShowPassOld.isHighlighted];
}
- (IBAction)toggleShowPassNew:(id)sender {
    _imageShowPassNew.highlighted = !_imageShowPassNew.isHighlighted;
    [_fieldNewPass setSecureTextEntry:!_imageShowPassNew.isHighlighted];
}

- (IBAction)updatePasswordOnClick:(id)sender {
    NSString *oldPass = _fieldOldPass.text;
    NSString *newPass = _fieldNewPass.text;
    NSString *confPass = _fieldConfirmationPass.text;
    
//    NSLog(@"userid %@ token %@ %@ %@ %@",_userID,_accessToken, oldPass, newPass, confPass);
    if(![newPass isEqualToString:confPass]){
        [SquadViewHelper.helper showMessage:@"New password didn't match." status:ERROR];
        return;
    }
    [Squad.instance passwordUpdateWithAccessToken:_accessToken userid:_userID oldPassword:oldPass newPassword:newPass respon:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            [SquadViewHelper.helper showMessage:response.display_message status:SUCCESS];
        }else{
            [SquadViewHelper.helper showMessage:response.display_message status:ERROR];
        }
    }];
}
- (IBAction)backOnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

@end

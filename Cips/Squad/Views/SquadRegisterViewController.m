//
//  SquadRegisterViewController.m
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import "SquadRegisterViewController.h"
#import <Cips/Cips.h>
#import "../SquadViewHelper.h"
#import "PopupMessage.h"

@interface SquadRegisterViewController ()<UITextFieldDelegate,PopupMessageDelegate>

@end

@implementation SquadRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)registerOnClick:(id)sender {
    SquadViewHelper *helper = [SquadViewHelper helper];
    NSString *firstName = _fiedlFirstName.text;
    NSString *lastName = _fieldLastName.text;
    NSString *email = _fieldEmail.text;
    NSString *pass = _fieldPassword.text;
    NSString *confPass = _fieldConfirmPassword.text;
    if([self checkFilled:firstName msg:@"First Name"]){
        return;
    }
    if([self checkFilled:lastName msg:@"Last Name"]){
        return;
    }
    if([self checkFilled:email msg:@"Email"]){
        return;
    }
    if([self checkFilled:pass msg:@"Password"]){
        return;
    }
    if([self checkFilled:confPass msg:@"Confirm Password"]){
        return;
    }
    if(pass.length < 8 || ![self isContainUpperCase:pass] || ![self isContainLowerCase:pass] || ![self isContainNumber:pass] ) {
        PopupMessage *popUp = [[PopupMessage alloc] init];
        [popUp show:@"Password must be contain at least one uppercase letter, 8 characters and one number (0-9)"];
        
        return;
    }
    
    if(![pass isEqualToString:confPass]){
       [helper showMessage:@"Passowrd didn't match" status:ERROR];
        return;
    }
    [helper addLoading];
    [Squad.instance registerFirstWithEmail:email password:pass firstName:firstName lastName:lastName companyid:Squad.instance.companyID redirecturi:@"http://web.squad.dev.codigo.id/forgot" verifyuri:@"http://web.squad.dev.codigo.id/" completion:^(SquadResponseModel *response) {
        NSLog(@"data %@",response.data);
        [helper removeLoading];
        if([response.status isEqualToString:@"200"]){
            PopupMessage *popUp = [[PopupMessage alloc] init];
            popUp.delegate = self;
            [popUp show:@"Success! Please Check your email to activate your account"];
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
}

-(void)popupOnDismiss{
    [self.navigationController popViewControllerAnimated:true];
}

- (BOOL)isUpperCase:(unichar)character{
    return [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:character];
}

- (BOOL)isContainUpperCase:(NSString *)str{
    BOOL containUppercase = false;
    for (int i = 0; i < [str length]; i++) {
        containUppercase = [self isUpperCase:[str characterAtIndex:i]];
        if(containUppercase){
            break;
        }
    }
    return containUppercase;
}

-(BOOL)isContainLowerCase:(NSString *)str{
    BOOL containLowercase = false;
    for (int i = 0; i < [str length]; i++) {
        containLowercase = ![self isUpperCase:[str characterAtIndex:i]];
        if(containLowercase){
            break;
        }
    }
    return containLowercase;
}

-(BOOL)isContainNumber:(NSString *)str{
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    BOOL containNumber = false;
    for (int i = 0; i < [str length]; i++) {
        containNumber = [set characterIsMember:[str characterAtIndex:i]];
        if(containNumber){
            break;
        }
    }
    return containNumber;
}

-(BOOL)checkFilled:(NSString *)str msg:(NSString *)msg{
    if(str.length > 0 ){
        return false;
    }
    NSLog(@"error");
    SquadViewHelper *helper = [SquadViewHelper helper];
    [helper showMessage:[NSString stringWithFormat:@"%@ Must be filled",msg] status:ERROR];
    return true;
}
- (IBAction)dismissView:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    _scrollView.contentInset = contentInsets;
//    _scrollView.scrollIndicatorInsets = contentInsets;
//    
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your application might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
//        [_scrollView setContentOffset:scrollPoint animated:YES];
//    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
}

@end

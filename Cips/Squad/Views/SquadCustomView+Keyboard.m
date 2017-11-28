//
//  SquadCustomView+Keyboard.m
//  Pods
//
//  Created by Fajar on 11/13/17.
//
//

#import "SquadCustomView+Keyboard.h"

@interface SquadCustomView_Keyboard(){
    NSLayoutConstraint *constraint;
}

@end


@implementation SquadCustomView_Keyboard


+(instancetype)initWithView:(UIView *)view andController:(UIViewController *)controller{
    SquadCustomView_Keyboard *keyboard = [[SquadCustomView_Keyboard alloc] init];
//    keyboard.field
    keyboard.view = view;
//    keyboard.controller = controller;
    [keyboard addNotif];
    return keyboard;
}

-(void)addNotif{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}



-(void)removeNotif{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

-(void)keyboardWillHidden:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue] << 16;
    __block CGRect rectView = _view.frame;
    [UIView animateWithDuration:animationDuration delay:0.0 options:curve animations:^{
        rectView.origin.y = _view.superview.frame.size.height - rectView.size.height;
        _view.frame = rectView;
    } completion:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    NSInteger curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue] << 16;
    __block CGRect rectView = _view.frame;
    [UIView animateWithDuration:animationDuration delay:0.0 options:curve animations:^{
        rectView.origin.y = _view.superview.frame.size.height - rectView.size.height -rect.size.height;
        _view.frame = rectView;
    } completion:nil];
}

@end

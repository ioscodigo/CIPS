//
//  SquadCustomView+Keyboard.h
//  Pods
//
//  Created by Fajar on 11/13/17.
//
//

#import <Foundation/Foundation.h>

@interface SquadCustomView_Keyboard : NSObject<UITextFieldDelegate>


@property (nonatomic,strong) UITextField *field;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *view;


+(instancetype)initWithView:(UIView *)view andController:(UIViewController *)controller;

-(void)addNotif;
-(void)removeNotif;

@end

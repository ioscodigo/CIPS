//
//  ErrorView.m
//  Pods
//
//  Created by Fajar on 10/19/17.
//
//

#import "StatusView.h"

@interface StatusView(){
    NSLayoutConstraint *bottom;
}

@end

@implementation StatusView



-(id)init{
    self = [super init];
    if(self){
        self.translatesAutoresizingMaskIntoConstraints = false;
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:label];
        CGFloat top = 7;
        if(![[UIApplication sharedApplication] isStatusBarHidden]){
            top += 20;
        }
        [[label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10] setActive:true];
        [[label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant: -10] setActive:true];
        [[label.topAnchor constraintEqualToAnchor:self.topAnchor constant:top] setActive:true];
        [[label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant: -7] setActive:true];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        label.textColor = [UIColor colorWithRed:245.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1];
        [self layoutIfNeeded];
    }
    return self;
}

-(void)setType:(STATUS_VIEW)status {
    UIColor *successColor = [UIColor colorWithRed:62.0/255.0 green:204.0/255.0 blue:19.0/255.0 alpha:1];
    UIColor *errorColor = [UIColor colorWithRed:254.0/255.0 green:56.0/255.0 blue:36.0/255.0 alpha:1];
    switch (status) {
        case SUCCESS:
            self.backgroundColor = successColor;
            break;
        case ERROR:
            self.backgroundColor = errorColor;
            break;
        default:
            break;
    }
    [self layoutIfNeeded];
}

-(void)show{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [self showOnView:window];
}

-(void)showOnView:(UIView *)view{
    [view addSubview:self];
    [[self.leadingAnchor constraintEqualToAnchor:view.leadingAnchor] setActive:true];
    [[self.trailingAnchor constraintEqualToAnchor:view.trailingAnchor] setActive:true];
    bottom = [self.bottomAnchor constraintEqualToAnchor:view.topAnchor];
    [bottom setActive:true];
    [view layoutIfNeeded];
    [UIView animateWithDuration:0.4 animations:^{
        bottom.constant =
        self.frame.size.height;
        [view layoutIfNeeded];
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.4 animations:^{
                bottom.constant = 0;
                [view layoutIfNeeded];
            }];
        });
    }];
}

-(instancetype)status:(NSString *)message type:(STATUS_VIEW)status{
    [self setType:status];
    [self setMesage:message];
    return self;
}

-(instancetype)setMessageColor:(UIColor *)color{
    UILabel *label = (UILabel *)self.subviews[0];
    label.textColor = color;
    return self;
}

-(void)setMesage:(NSString *)text{
    UILabel *label = (UILabel *)self.subviews[0];
    label.text = text;
}

-(void)dismissView{
    [UIView animateWithDuration:0.4 animations:^{
        bottom.constant = 0;
        [self.superview layoutIfNeeded];
    }];
}


@end

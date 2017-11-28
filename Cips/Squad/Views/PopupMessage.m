//
//  PopupMessage.m
//  Pods
//
//  Created by Fajar on 11/7/17.
//
//

#import "PopupMessage.h"

@interface PopupMessage(){
    UILabel *labelMessage;
}
@end

@implementation PopupMessage


-(id)init{
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        UIView *view = [[UIView alloc] init];
        view.translatesAutoresizingMaskIntoConstraints = false;
        self.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:view];
//        [[view.centerXAnchor constraintEqualToAnchor:self.centerXAnchor] setActive:true];
        [[view.centerYAnchor constraintEqualToAnchor:self.centerYAnchor] setActive:true]
        ;
        [[view.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:44] setActive:true];
        [[view.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-44] setActive:true];
        view.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:246.0/255.0 blue:247.0/255.0 alpha:1];
        view.layer.cornerRadius = 8;
        [view setClipsToBounds:true];
        
        labelMessage = [[UILabel alloc] init];
        labelMessage.translatesAutoresizingMaskIntoConstraints = false;
        [view addSubview:labelMessage];
        [[labelMessage.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:44] setActive:true];
        [[labelMessage.trailingAnchor constraintEqualToAnchor:view.trailingAnchor constant:-44] setActive:true];
        [[labelMessage.topAnchor constraintEqualToAnchor:view.topAnchor constant:33] setActive:true];
        [[labelMessage.bottomAnchor constraintEqualToAnchor:view.bottomAnchor constant:-33] setActive:true];
        labelMessage.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1];
        labelMessage.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        labelMessage.textAlignment = NSTextAlignmentCenter;
        labelMessage.numberOfLines = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageOnTap)];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
        [self layoutIfNeeded];
    }
    return self;
}

-(void)show:(NSString *)msg{
    labelMessage.text = msg;
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    [[self.leadingAnchor constraintEqualToAnchor:window.leadingAnchor] setActive:true];
    [[self.trailingAnchor constraintEqualToAnchor:window.trailingAnchor] setActive:true];
    [[self.topAnchor constraintEqualToAnchor:window.topAnchor] setActive: true];
    [[self.bottomAnchor constraintEqualToAnchor:window.bottomAnchor] setActive:true];
    [self layoutIfNeeded];
}


-(void)messageOnTap{
    if(_delegate){
        [_delegate popupOnDismiss];
    }
    [self removeFromSuperview];
}

@end

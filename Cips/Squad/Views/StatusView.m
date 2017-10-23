//
//  ErrorView.m
//  Pods
//
//  Created by Fajar on 10/19/17.
//
//

#import "StatusView.h"

@implementation StatusView

-(void)setType:(STATUS)status {
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
}

-(instancetype)status:(NSString *)message type:(STATUS)status{
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


@end

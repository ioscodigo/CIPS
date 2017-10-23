//
//  SquadCustomView.m
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import "SquadCustomView.h"

@implementation SquadCustomView


-(void)setBorderColor:(UIColor *)newValue{
    [self.layer setBorderColor:newValue.CGColor];
}

-(void)setBorderWidth:(CGFloat)borderWidth{
    [self.layer setBorderWidth:borderWidth];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}


@end

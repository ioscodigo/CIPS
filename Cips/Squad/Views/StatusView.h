//
//  ErrorView.h
//  Pods
//
//  Created by Fajar on 10/19/17.
//
//

#import <UIKit/UIKit.h>
#import "../SquadViewHelper.h"


@interface StatusView : UIView

-(instancetype)status:(NSString *)message type:(STATUS_VIEW)status;
-(instancetype)setMessageColor:(UIColor *)color;
-(void)showOnView:(UIView *)view;
-(void)show;
@end

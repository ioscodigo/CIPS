//
//  PopupMessage.h
//  Pods
//
//  Created by Fajar on 11/7/17.
//
//

#import <UIKit/UIKit.h>

@protocol PopupMessageDelegate

-(void)popupOnDismiss;

@end

@interface PopupMessage : UIView

@property (nonatomic) id<PopupMessageDelegate> delegate;

-(void)show:(NSString *)msg;
@end

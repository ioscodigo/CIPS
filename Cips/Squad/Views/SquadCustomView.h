//
//  SquadCustomView.h
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface SquadCustomView : UIView

@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable BOOL addAllBorder;
@property (nonatomic) IBInspectable BOOL addLeftBorder;
@property (nonatomic) IBInspectable BOOL addRightBorder;
@property (nonatomic) IBInspectable BOOL addTopBorder;
@property (nonatomic) IBInspectable BOOL addBottomBorder;


@end

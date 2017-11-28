//
//  SquadCustomView.m
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import "SquadCustomView.h"

#define TAG_BORDER_TOP      56
#define TAG_BORDER_BOTTOM   57
#define TAG_BORDER_LEFT     58
#define TAG_BORDER_RIGHT    59

@interface SquadCustomView(){
}

@end

@implementation SquadCustomView


//-(void)setBorderColor:(UIColor *)newValue{
//    
////    [self.layer setBorderColor:newValue.CGColor];
//}

//-(void)setBorderWidth:(CGFloat)borderWidth{
////    [self.layer setBorderWidth:borderWidth];
//}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
}

-(void)layoutSubviews{
    [self removeView:TAG_BORDER_TOP];
    [self removeView:TAG_BORDER_BOTTOM];
    [self removeView:TAG_BORDER_LEFT];
    [self removeView:TAG_BORDER_RIGHT];
    if(_addBottomBorder)
        [self addBottomBorderWithColor:_borderColor andWidth:_borderWidth];
    if(_addTopBorder)
        [self addTopBorderWithColor:_borderColor andWidth:_borderWidth];
    if(_addLeftBorder)
        [self addLeftBorderWithColor:_borderColor andWidth:_borderWidth];
    if(_addRightBorder)
        [self addRightBorderWithColor:_borderColor andWidth:_borderWidth];
}

-(void)setAddAllBorder:(BOOL)addAllBorder{
    if(addAllBorder){
        [self removeView:TAG_BORDER_TOP];
        [self removeView:TAG_BORDER_BOTTOM];
        [self removeView:TAG_BORDER_LEFT];
        [self removeView:TAG_BORDER_RIGHT];
        _addTopBorder = false;
        _addBottomBorder = false;
        _addLeftBorder = false;
        _addRightBorder = false;
        [self.layer setBorderColor:_borderColor.CGColor];
        [self.layer setBorderWidth:_borderWidth];
    }else{
        [self.layer setBorderWidth:0];
    }
}

-(void)setAddTopBorder:(BOOL)addTopBorder{
    _addTopBorder = addTopBorder;
    if(addTopBorder){
        [self addTopBorderWithColor:_borderColor andWidth:_borderWidth];
    }else{
        [self removeView:TAG_BORDER_TOP];
    }
}

-(void)setAddBottomBorder:(BOOL)addBottomBorder{
    _addBottomBorder = addBottomBorder;
    if(addBottomBorder){
        [self addBottomBorderWithColor:_borderColor andWidth:_borderWidth];
    }else{
        [self removeView:TAG_BORDER_BOTTOM];
    }
}

-(void)setAddLeftBorder:(BOOL)addLeftBorder{
    _addLeftBorder = addLeftBorder;
    if(addLeftBorder){
        [self addLeftBorderWithColor:_borderColor andWidth:_borderWidth];
    }else{
        [self removeView:TAG_BORDER_LEFT];
    }
}

-(void)setAddRightBorder:(BOOL)addRightBorder{
    _addRightBorder = addRightBorder;
    if(addRightBorder){
        [self addRightBorderWithColor:_borderColor andWidth:_borderWidth];
    }else{
        [self removeView:TAG_BORDER_RIGHT];
    }
}

-(void)removeView:(int)tag{
    UIView *view = [self viewWithTag:tag];
    if(view){
        [view removeFromSuperview];
    }
}



-(UIView *)templateBorder:(UIColor*)color{
    [self.layer setBorderWidth:0];
    _addAllBorder = false;
    UIView *border = [UIView new];
    border.backgroundColor = color;
    border.translatesAutoresizingMaskIntoConstraints = false;
    return border;
}


- (void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [self templateBorder:color];
    border.tag = TAG_BORDER_TOP;
    [self addSubview:border];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[top(==thickness)]" options:0 metrics:@{@"thickness": @(borderWidth)} views:@{@"top": border}]
     ];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[top]-(0)-|" options:0 metrics:nil views:@{@"top": border}]
     ];
}



- (void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [self templateBorder:color];
    border.tag = TAG_BORDER_BOTTOM;
    [self addSubview:border];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottom(==thickness)]-(0)-|" options:0 metrics:@{@"thickness": @(borderWidth)} views:@{@"bottom": border}]
     ];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[bottom]-(0)-|" options:0 metrics:nil views:@{@"bottom": border}]
     ];
}

- (void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [self templateBorder:color];
    border.tag = TAG_BORDER_LEFT;
    [self addSubview:border];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[left(==thickness)]" options:0 metrics:@{@"thickness": @(borderWidth)} views:@{@"left": border}]
     ];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[left]-(0)-|" options:0 metrics:nil views:@{@"left": border}]
     ];
}

- (void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    UIView *border = [self templateBorder:color];
    border.tag = TAG_BORDER_RIGHT;
    [self addSubview:border];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:[right(==thickness)]-(0)-|" options:0 metrics:@{@"thickness": @(borderWidth)} views:@{@"right": border}]
     ];
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[right]-(0)-|" options:0 metrics:nil views:@{@"right": border}]
     ];
}


@end

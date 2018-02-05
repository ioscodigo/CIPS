//
//  SpotlightSupport.h
//  Chips_Example
//
//  Created by Fajar on 1/29/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpotlightSupport : NSObject

@property (nonatomic,strong) NSString *channelNo;
@property (nonatomic) bool channelSelected;
+(instancetype)service;
+(void)showMessage:(NSString *)title msg:(NSString *)msg vc:(UIViewController *)vc;
@end

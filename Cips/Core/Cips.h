//
//  Chips.h
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//


#import <Foundation/Foundation.h>
#if __has_include(<Cips/Squad.h>)
#import "Cips/Squad.h"
#endif
#if __has_include(<Cips/Qnock.h>)
#import "Cips/Qnock.h"
#endif
#if __has_include(<Cips/Spotlight.h>)
#import "Cips/Spotlight.h"
#endif

@interface Cips : NSObject


//@property (nonatomic, strong) Squad *squad;
//@property (nonatomic, weak) Qnock *qnock;

+(instancetype)service;


@end


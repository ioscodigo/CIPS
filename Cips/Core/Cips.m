//
//  Cips.m
//  Pods
//
//  Created by Fajar on 10/9/17.
//
//

#ifndef Cips_h
#define Cips_h


#endif /* Chips_h */

#import "Cips.h"




@implementation Cips
static Cips *sharedInstance = nil;

//Squad* squad;
//Qnock* qnock;

+(instancetype)service
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[Cips alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        
    }
    return self;
}

@end

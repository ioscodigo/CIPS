//
//  Cips+NSString.m
//  Pods
//
//  Created by Fajar on 9/26/17.
//
//

#import "Cips+NSString.h"
#import "CipsConfig.h"

@implementation NSString(CIPS)

-(NSString *)environment{
    switch ([Cips instance].env) {
        case PRODUCTION:
            return self;
        case SANDBOX:
            return self;
        default:
            return self;
    }
}

@end

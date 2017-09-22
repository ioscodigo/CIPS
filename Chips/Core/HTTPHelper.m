//
//  HTTPHelper.m
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import "HTTPHelper.h"



@implementation HTTPHelper

static HTTPHelper *obj = nil;

+(HTTPHelper*)instance
{
    @synchronized([HTTPHelper class])
    {
        if (!obj)
        [[self alloc] init];
        
        return obj;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([HTTPHelper class])
    {
        NSAssert(obj == nil, @"Attempted to allocate a second instance of a singleton.");
        obj = [super alloc];
        return obj;
    }
    
    return nil;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
    }
    
    return self;
}

@end

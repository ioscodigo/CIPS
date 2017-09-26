//
//  Qnock.m
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import "Qnock.h"

@implementation Qnock

static Qnock *obj = nil;

+(Qnock*)instance
{
    @synchronized([Qnock class])
    {
        if (!obj)
        [[self alloc] init];
        
        return obj;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([Qnock class])
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

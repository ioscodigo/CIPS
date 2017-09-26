//
//  ChipsConfig.m
//  Pods
//
//  Created by Fajar on 9/26/17.
//
//

#import "CipsConfig.h"

@interface Cips(){
    NSString *AppKey;
    NSString *ScreetKey;
}

@end

@implementation Cips

static Cips *obj = nil;

+(Cips*)instance
{
    @synchronized([Cips class])
    {
        if (!obj)
            [[self alloc] init];
        
        return obj;
    }
    
    return nil;
}


+(void)initializeWithAppkey:(NSString *)AppKey withSecretKey:(NSString *)SecretKey{
    Cips *cips = [Cips instance];
}

+(id)alloc
{
    @synchronized([Cips class])
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

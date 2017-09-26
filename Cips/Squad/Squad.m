//
//  Squad.m
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import "Squad.h"
#import "Cips/CipsHTTPHelper.h"
#import <Cips/Cips+NSString.h>
#import "SquadResponseModel.h"
#import "Internal/SquadConstant.h"

@implementation Squad


static Squad *obj = nil;

+(Squad*)instance
{
    @synchronized([Squad class])
    {
        if (!obj)
        [[self alloc] init];
        
        return obj;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([Squad class])
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

-(void)loginWithUser:(NSString *)user andPassoword:(NSString *)password{
    [[CipsHTTPHelper instance] requestFormDataWithMethod:POST WithUrl:SQUAD_BASE.environment withParameter:@{} withBlock:^(CipsHTTPResponse *response) {
        
    }];
}


@end

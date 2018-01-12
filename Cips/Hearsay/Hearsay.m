//
//  Hearsay.m
//  Pods
//
//  Created by Fajar on 12/27/17.
//
//

#import "Hearsay.h"

@implementation Hearsay



//SquadAPI *api;

static Hearsay *obj = nil;

+(Hearsay*)instance
{
    @synchronized([Hearsay class])
    {
        if (!obj)
            NSAssert(false,@"Instance not available, please init with clientid and client secret");
        
        return obj;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([Hearsay class])
    {
        NSAssert(obj == nil, @"Attempted to allocate a second instance of a singleton.");
        obj = [super alloc];
        return obj;
    }
    
    return nil;
}

-(id)init {
    return nil;
}

-(id)initWithID:(NSString *)clientid secret:(NSString *)clientSecret withCompanyId:(NSString *)companyID{
    [Hearsay alloc];
    if (obj != nil) {
//        api = [[SquadAPI alloc] initWithSecretKey:clientid withClientid:clientSecret withCompanyId:companyID];
//        self.companyID = companyID;
    }
    return obj;
}

+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret withCompanyId:(NSString *)companyID{
    [Hearsay alloc];
//    api = [[SquadAPI alloc] initWithSecretKey:clientSecret withClientid:clientID withCompanyId:companyID];
}


@end

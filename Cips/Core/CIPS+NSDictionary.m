//
//  CIPS+NSDictionary.m
//  Pods
//
//  Created by Fajar on 11/1/17.
//
//

#import "CIPS+NSDictionary.h"

@implementation NSDictionary(CIPS)

-(NSString *)StringForKey:(NSString *)key{
    if([self hasKey:key]){
        id object = [self objectForKey:key];
        if(object){
            return [NSString stringWithFormat:@"%@",object];
        }
    }
    return @"";
}

-(BOOL)BoolForKey:(NSString *)key{
    if([self hasKey:key]){
        id object = [self objectForKey:key];
        if(object){
            return (int)object;
        }
    }
    return 0;
}

-(NSDictionary *)dictionaryForKey:(NSString *)key{
    if([self hasKey:key]){
        id object = [self objectForKey:key];
        if(object){
            return (NSDictionary *)object;
        }
    }
    return [[NSDictionary alloc] init];
}

- (BOOL)hasKey: (NSString *)key {
    BOOL retVal = 0;
    NSArray *allKeys = [self allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
}

@end

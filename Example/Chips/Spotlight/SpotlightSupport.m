//
//  SpotlightSupport.m
//  Chips_Example
//
//  Created by Fajar on 1/29/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightSupport.h"

@implementation SpotlightSupport


static SpotlightSupport *sharedInstance = nil;




+(instancetype)service
{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[SpotlightSupport alloc] init];
    });
    return sharedInstance;
}

-(id)init {
    self = [super init];
    if (self != nil) {
    }
    return self;
}

+(void)showMessage:(NSString *)title msg:(NSString *)msg vc:(UIViewController *)vc{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dissmis" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:true completion:nil];
    }]];
    [vc presentViewController:alert animated:true completion:nil];
}

@end



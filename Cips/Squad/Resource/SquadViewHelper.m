//
//  SquadViewHelper.m
//  Pods
//
//  Created by Fajar on 10/12/17.
//
//

#import "SquadViewHelper.h"
#import "SquadLoginViewController.h"

@implementation SquadViewHelper

NSURL *bundleURL;
NSBundle *bundle;
UIStoryboard *storyBoard;

-(id)init{
    self = [super init];
    if (self) {
        bundleURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"CipsSquad" withExtension:@"bundle"];
        bundle = [NSBundle bundleWithURL:bundleURL];
        storyBoard = [UIStoryboard storyboardWithName:@"Squad" bundle:bundle];
    }
    return self;
}

-(void)viewController{
    UIViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"SquadLoginVC"];
//    NSLog(@"controller %@",(SquadLoginViewController *)controller);
//    NSLog(@"bundle %@",[bundle resourcePath]);
}

@end

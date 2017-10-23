//
//  SquadViewHelper.m
//  Pods
//
//  Created by Fajar on 10/12/17.
//
//

#import "SquadViewHelper.h"

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

-(UIViewController *)viewController{
    UIViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"SquadLoginVC"];
    return controller;
//    NSLog(@"controller %@",(SquadLoginViewController *)controller);
//    NSLog(@"bundle %@",[bundle resourcePath]);
}

-(StatusView *)statusView{
    UIView *view = [[bundle loadNibNamed:@"StatusView" owner:self options:nil] objectAtIndex:0];
    StatusView *status = [view.subviews objectAtIndex:0];
    return status;
}

@end

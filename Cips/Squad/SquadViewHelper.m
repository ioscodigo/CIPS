//
//  SquadViewHelper.m
//  Pods
//
//  Created by Fajar on 10/12/17.
//
//

#import "SquadViewHelper.h"
#import "Views/SquadRegisterViewController.h"
#import "Views/SquadLoginViewController.h"
#import "Views/SquadProfileViewController.h"
#import "Views/StatusView.h"


@implementation SquadViewHelper

static SquadViewHelper *sharedInstance;

NSURL *bundleURL;
NSBundle *bundle;
int LOADINGTAG = 9912;


-(id)init{
    self = [super init];
    if (self) {
        bundleURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"CipsSquad" withExtension:@"bundle"];
        bundle = [NSBundle bundleWithURL:bundleURL];
        _storyboard = [UIStoryboard storyboardWithName:@"Squad" bundle:bundle];
    }
    return self;
}

+(SquadViewHelper *)helper{
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[SquadViewHelper alloc] init];
    });
    return sharedInstance;
}

+(void)SquadLoginViewWithController:(UIViewController *)controller withRedirectURL:(NSString *)redirect withVerifyURL:(NSString *)verify autoVerifyRegister:(bool)autoVerify delegate:(id<SquadControllerDelegate>)delegate{
    SquadViewHelper *helper = [SquadViewHelper helper];
    SquadLoginViewController *login = [helper.storyboard instantiateViewControllerWithIdentifier:@"SquadLoginVC"];
    login.delegate = delegate;
    login.isAutoVerifyRegister = autoVerify;
    login.redirectURI = redirect;
    login.verifyURI = verify;
    UINavigationController *NavController = [[UINavigationController alloc] initWithRootViewController:login];
    [NavController setNavigationBarHidden:true];
    [controller presentViewController:NavController animated:true completion:nil];
}

+(void)SquadProfileViewWithController:(UIViewController *)controller token:(NSString *)access_token{
    SquadViewHelper *helper = [SquadViewHelper helper];
    SquadProfileViewController *profile = [helper.storyboard instantiateViewControllerWithIdentifier:@"profileVC"];
    profile.accessToken = access_token;
    UINavigationController *NavController = [[UINavigationController alloc] initWithRootViewController:profile];
    [NavController setNavigationBarHidden:true];
    [controller presentViewController:NavController animated:true completion:nil];
}

-(void)addLoading{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *view = [[UIView alloc] initWithFrame:window.bounds];
    view.tag = LOADINGTAG;
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:view.bounds];
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [view addSubview:indicator];
    [indicator startAnimating];
    [window addSubview:view];
}

-(void)removeLoading{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *view = [window viewWithTag:LOADINGTAG];
    if(view){
        [view removeFromSuperview];
    }
}

-(void)showMessage:(NSString *)msg status:(STATUS_VIEW)status{
    StatusView *view = [[StatusView alloc] init];
    [view status:msg type:status];
    [view show];
}

-(void)popupMessage:(NSString *)msg{
    
}
//+(SquadLoginViewController *)loginViewController:(id<SquadControllerDelegate>)delegate{
//    SquadViewHelper *helper = [SquadViewHelper helper];
//    SquadLoginViewController *controller =(SquadLoginViewController *)[helper.storyboard instantiateViewControllerWithIdentifier:@"SquadLoginVC"];
//    return controller;
//}


@end

//
//  ChipsAppDelegate.m
//  Chips
//
//  Created by fajaraw on 09/22/2017.
//  Copyright (c) 2017 fajaraw. All rights reserved.
//

#import "ChipsAppDelegate.h"
#import <Cips/Cips.h>
#import "QnockPushViewController.h"
#import <Firebase.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <TwitterKit/TWTRKit.h>
//import UserNotifications
//#import <Firebase>


@implementation ChipsAppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Qnock initWithClientId:@"MtXJoYnarJBb" withClientSecret:@"heJhiRFsfq" completion:^(NSString *responseToken) {
//
    }];
    [FIRApp configure];
    [FIRMessaging messaging].delegate = self;
    
    [[Twitter sharedInstance] startWithConsumerKey:@"ra5tx5wdSXhYyOtnOKljqn7Bt" consumerSecret:@"BgMD63gohasIJVz15GKyASs1XCYJKjEcD9OHTLflyl9XpAippf"];

//    [Qnock initWithClientId:@"8" withClientSecret:@"Z6AJioWnew" completion:^(NSString *responseToken) {
//        NSLog(@"repons %@", responseToken);
//    }];
    // Override point for customization after application launch.
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
#endif
    }
    [application registerForRemoteNotifications];

    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary *data = notification.request.content.userInfo;
    NSLog(@"willnotif %@",data);
    [Qnock.instance notifReceived:data];
    [self showNotif:data];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSLog(@"didnotif");
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSLog(@"%@", userInfo);
    [Qnock.instance notifReceived:userInfo];
    [self showNotif:userInfo];
//    NSObject *data =
//    if([data isKindOfClass:[NSString class]]){
//        NSString *d = (NSString *)data;
//        UIViewController *controller = [self visibleViewController:UIApplication.sharedApplication.keyWindow.rootViewController];
//        if([controller isKindOfClass:[QnockPushViewController class]]){
//            
//        }else{
//            QnockPushViewController *push = (QnockPushViewController *)[controller.storyboard instantiateViewControllerWithIdentifier:@"qnockPushVC"];
//            push.labelUnixID.text = [userInfo objectForKey:@"unix_id"];
//            push.labelTittle.text = [userInfo objectForKey:@"title"];
//            push.labelMessage.text = [userInfo objectForKey:@"body"];
//        }
//        //        UIApplication.sharedApplication.win
//    }
}

-(void)showNotif:(NSDictionary *)userInfo{
    UIViewController *controller = [self visibleViewController:UIApplication.sharedApplication.keyWindow.rootViewController];
    if([controller isKindOfClass:[QnockPushViewController class]]){
        QnockPushViewController *push = (QnockPushViewController *)controller;
                push.labelUnixID.text = [userInfo objectForKey:@"unix_id"];
                NSDictionary *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
                push.labelTittle.text = [alert objectForKey:@"title"];
                push.labelMessage.text = [alert objectForKey:@"body"];
                push.labelData.text = [userInfo objectForKey:@"data"];
    }else{
        QnockPushViewController *push = (QnockPushViewController *)[controller.storyboard instantiateViewControllerWithIdentifier:@"qnockPushVC"];
//        push.labelUnixID.text = [userInfo objectForKey:@"unix_id"];
//        NSDictionary *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
//        push.labelTittle.text = [alert objectForKey:@"title"];
//        push.labelMessage.text = [alert objectForKey:@"body"];
//        push.labelData.text = [userInfo objectForKey:@"data"];
        push.userInfo = userInfo;
        [controller presentViewController:push animated:true completion:nil];
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    BOOL tw = [[Twitter sharedInstance] application:application openURL:url options:options];
    return handled || tw;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage{
    NSLog(@"msgfcm %@",remoteMessage);
}

-(void)messaging:(FIRMessaging *)messaging didRefreshRegistrationToken:(NSString *)fcmToken{
    NSLog(@"tokenfcm %@",fcmToken);
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"content---%@", token);
    FIRMessaging.messaging.APNSToken = deviceToken;
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Print full message.
    NSLog(@"%@", userInfo);
    NSObject *data = [Qnock.instance notifReceived:userInfo];
    if([data isKindOfClass:[NSString class]]){
//        NSString *d = (NSString *)data;
        UIViewController *controller = [self visibleViewController:UIApplication.sharedApplication.keyWindow.rootViewController];
        if([controller isKindOfClass:[QnockPushViewController class]]){
            
        }else{
            QnockPushViewController *push = (QnockPushViewController *)[controller.storyboard instantiateViewControllerWithIdentifier:@"qnockPushVC"];
            push.labelUnixID.text = [userInfo objectForKey:@"unix_id"];
            push.labelTittle.text = [userInfo objectForKey:@"title"];
            push.labelMessage.text = [userInfo objectForKey:@"body"];
        }
//        UIApplication.sharedApplication.win
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
    NSLog(@"received");
}




- (UIViewController *)visibleViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil)
    {
        return rootViewController;
    }
    if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        
        return [self visibleViewController:lastViewController];
    }
    if ([rootViewController.presentedViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController.presentedViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        
        return [self visibleViewController:selectedViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    
    return [self visibleViewController:presentedViewController];
}



@end

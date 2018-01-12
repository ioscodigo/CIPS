//
//  ChipsAppDelegate.h
//  Chips
//
//  Created by fajaraw on 09/22/2017.
//  Copyright (c) 2017 fajaraw. All rights reserved.
//

@import UIKit;
@import UserNotifications;
#import <FirebaseMessaging/FirebaseMessaging.h>

@interface ChipsAppDelegate : UIResponder <UIApplicationDelegate,FIRMessagingDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

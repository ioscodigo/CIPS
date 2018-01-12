//
//  SpotlightTestingViewController.m
//  Chips
//
//  Created by Fajar on 1/11/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightTestingViewController.h"

#define APPS_SECRET @"3c516b727d7d67392e486d435731294b3e686e2f4e6636524d466b4265537b3f374b58254b3f67333e5a37395d515a26536b"
#define APPS_ID @"BRANCH001"
#define COMPANY_ID @"1"

@interface SpotlightTestingViewController ()

@end

@implementation SpotlightTestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Spotlight initWithAppsSecret:APPS_SECRET withClientId:APPS_ID withCompanyId:COMPANY_ID completion:^(bool isSuccess, NSString *responseToken) {
        NSLog(@"LOGIN SPOTLIGHT %@",responseToken);
        [Spotlight.instance spotlightHomepageHeadlineWithChannel:@"CHANNEL01517" onComplete:^(SpotlightResponseModel *response) {
            NSLog(@"STATUS %@",response.status);
            NSLog(@"MESSAGE %@",response.message);
            NSLog(@"DATA %@",response.data);
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

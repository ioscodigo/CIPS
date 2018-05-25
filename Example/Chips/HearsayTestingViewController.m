//
//  HearsayTestingViewController.m
//  Chips_Example
//
//  Created by Fajar on 4/2/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "HearsayTestingViewController.h"
#import <Cips/Cips.h>
#import "HearsayCommentViewController.h"
#import <Cips/SquadViewHelper.h>

#define HEARSAY_APPS_ID @"4a694a4c613e"
#define HEARSAY_APPS_SECRET @"414e6132466d37327d636e336d6b7d21713129216546752f377924673e4b2361395041654637712f6e62322f522a34303748"
#define HEARSAY_COMPANY_ID @"28"

//#define HEARSAY_APPS_ID @"303633493377"
//#define HEARSAY_APPS_SECRET @"3a2c662963392e474e5324522c514955315029716c36696436556757627d4b7d79334e425033546457657851764526474525"
//#define HEARSAY_COMPANY_ID @"46"

@interface HearsayTestingViewController ()


@end

@implementation HearsayTestingViewController

Hearsay *instance;
- (void)viewDidLoad {
    [super viewDidLoad];
//    [Hearsay initWithID:HEARSAY_APPS_ID secret:HEARSAY_APPS_SECRET withCompanyId:HEARSAY_COMPANY_ID onComplete:^(HearsayResponseModel *response) {
//        NSLog(@"HEARSAY %@",response.data);
////        [[Hearsay instance] commentPostWithContent:@"Test Comment SDK 2" withUserId:@"1001" withEmail:@"" withUsername:@"username" withPostId:@"500000" withArticleName:@"name" onComplete:^(HearsayResponseModel *response) {
////            NSLog(@"response post %@",response.display_message);
////        }];
////        [[Hearsay instance] commentReplyWithContent:@"Test Reply Comment SDK" withCommentId:@"5840" withUserId:@"235" withEmail:@"" withUsername:@"username" withArticleName:@"a" onComplete:^(HearsayResponseModel *response) {
////            NSLog(@"response reply %@",response.display_message);
////        }];
//        instance = [Hearsay instance];
//
//        [self voteComment];
//    }];
}

-(void)viewDidAppear:(BOOL)animated{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Environment" message:@"Select Environment" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"PRODUCTION" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loginHearsay:PRODUCTION];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"SANDBOX" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self loginHearsay:SANDBOX];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

-(void)loginHearsay:(CIPSENVIRONMENT)env{
    SquadViewHelper *helper = [SquadViewHelper helper];
    [helper addLoading];
    [Hearsay initWithID:HEARSAY_APPS_ID secret:HEARSAY_APPS_SECRET withCompanyId:HEARSAY_COMPANY_ID environment:env onComplete:^(HearsayResponseModel *response) {
        [helper removeLoading];
        if(response.isSuccess && [response.status isEqualToString:@"200"]){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Hearsay" bundle:nil];
            UIViewController *comment = [storyboard instantiateViewControllerWithIdentifier:@"hearsayViewVC"];
            [self presentViewController:comment animated:true completion:nil];
        }else{
            [helper showMessage:response.display_message status:ERROR];
        }
    }];
}

-(void)getMainComment{
//    [instance getCommentWithPostId:@"500000" withUserId:@"0" withLimit:@"10" withOffset:@"0" onComplete:^(HearsayResponseModel *response) {
//        NSLog(@"response coomment %@",response.data);
//    }];
}

-(void)getCHildComment{
//    [instance getChildCommentWithCommentID:@"5850" withUserId:@"0" withLimit:@"10" withOffset:@"0" onComplete:^(HearsayResponseModel *response) {
//         NSLog(@"response child coomment %@",response.data);
//    }];
}

-(void)getCategoryReport{
    [instance getCategoryReport:^(HearsayResponseModel *response) {
        NSLog(@"response category %@",response.data);
    }];
}

-(void)reportComment{
    [instance reportCommentWithCommentId:@"5840" withReportId:@"1" withReason:@"a" withUserId:@"1" onComplete:^(HearsayResponseModel *response) {
        NSLog(@"response report %@",response.display_message);
    }];
}

-(void)voteComment{
    [instance voteCommentWithCommentId:@"5840" withUserId:@"1" withVoteType:1 onComplete:^(HearsayResponseModel *response) {
       NSLog(@"response vote %@",response.display_message);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

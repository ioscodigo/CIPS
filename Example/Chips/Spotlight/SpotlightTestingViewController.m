//
//  SpotlightTestingViewController.m
//  Chips
//
//  Created by Fajar on 1/22/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightTestingViewController.h"
#import "SpotlightStoryListViewController.h"
#import "SpotlightSupport.h"

#define APPS_SECRET @"3c516b727d7d67392e486d435731294b3e686e2f4e6636524d466b4265537b3f374b58254b3f67333e5a37395d515a26536b"
#define APPS_ID @"BRANCH001"
#define COMPANY_ID @"1"

//#define APPS_SECRET @"3c516b727d7d67392e486d435731294b3e686e2f4e6636524d466b4265537b3f374b58254b3f67333e5a37395d515a26536b"
//#define APPS_ID @"3c49756d3c56"
//#define COMPANY_ID @"5"

@interface SpotlightTestingViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbuttonenvironment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SpotlightTestingViewController


UIStoryboard *spotlightStoryboard;
NSArray *list;
bool isLogin = false;


- (void)viewDidLoad {
    [super viewDidLoad];
    list = @[@"Login",@"Channel List",@"Homepage",@"Story List",@"Story List With Channel",@"Article List",@"Live Streaming",@"Search"];
    spotlightStoryboard = [UIStoryboard storyboardWithName:@"Spotlight" bundle:nil];
//    [Spotlight initWithAppsSecret:APPS_SECRET withClientId:APPS_ID withCompanyId:COMPANY_ID completion:^(bool isSuccess, NSString *responseToken) {
//        NSLog(@"LOGIN SPOTLIGHT %@",responseToken);
//        [Spotlight.instance spotlightHomepageHeadlineWithChannel:@"CHANNEL01517" onComplete:^(SpotlightResponseModel *response) {
//            NSLog(@"STATUS %@",response.status);
//            NSLog(@"MESSAGE %@",response.message);
//            NSLog(@"DATA %@",response.data);
//        }];
//    }];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
    [_tableView reloadData];
//    [SpotlightSupport service].channelNo = @"CHANNEL00217";
    [SpotlightSupport service].channelNo = @"CHANNEL14418";
    NSLog(@"TEST");
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(channelSelected ? @"selected":@"false");
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)cell.contentView.subviews[0];
    label.text = list[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *listIdentifier = @[@"",@"spotlightChannelListVC",@"spotlightHomepageVC",@"spotlightStoryListVC",@"spotlightStoryListVC",@"spotlightArticleVC",@"spotlightLiveStreamingListVC",@"spotlightSearchVC"];
    switch (indexPath.row) {    
        case 0:
        {
            NSLog(@"test log %@",list);
            if(!isLogin){
            [Spotlight initWithAppsSecret:APPS_SECRET withClientId:APPS_ID withCompanyId:COMPANY_ID completion:^(bool isSuccess, NSString *responseToken) {
                NSLog(@"LOGIN SPOTLIGHT %@",responseToken);
                [self showMessage:@"Success" msg:@"Success Login Spotlight"];
                isLogin = true;
            }];
            }else{
                [self showMessage:@"Error" msg:@"Already Login"];
            }
        break;
        }
        case 4:
        {
            if(!channelSelected && isLogin){
                SpotlightStoryListViewController *vc =(SpotlightStoryListViewController *) [spotlightStoryboard instantiateViewControllerWithIdentifier:listIdentifier[indexPath.row]];
                vc.isChannel = true;
                vc.channelName = channelName;
                [self.navigationController pushViewController:vc animated:true];
            }else if(isLogin){
                [self showMessage:@"Failed" msg:@"Please Select Channel first."];
            }else{
                [self showMessage:@"Failed" msg:@"Please login first."];
            }
            break;
        }
        default:
        {
            if(isLogin){
                [self showViewControllerWithIdentifier:listIdentifier[indexPath.row]];
            }else{
                [self showMessage:@"Failed" msg:@"Please login first."];
            }
            break;
        }
    }
}

-(void)showViewControllerWithIdentifier:(NSString *)identifer {
    
    UIViewController *vc = [spotlightStoryboard instantiateViewControllerWithIdentifier:identifer];
    
    [self.navigationController pushViewController:vc animated:true];
}

-(void)showMessage:(NSString *)title msg:(NSString *)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Dissmis" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:true completion:nil];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeEnvironment:(id)sender {
    if(isLogin){
        if(_barbuttonenvironment.tag == 0){
        [Spotlight.instance spotlightChangeEnvironment:SANDBOX onComplete:^(bool isSuccess, NSString *responseToken) {
            if(isSuccess){
                _barbuttonenvironment.tag = 1;
                [_barbuttonenvironment setTitle:@"Production"];
                [self showMessage:@"Status" msg:@"Success change to SANDBOX"];
            }else{
                [Spotlight.instance spotlightChangeEnvironment:PRODUCTION onComplete:^(bool isSuccess, NSString *responseToken) {
                    if(isSuccess){;
                        [self showMessage:@"Status" msg:@"Success back to PRODUCTION"];
                    }
                }];
                [self showMessage:@"Status" msg:@"Gagal Login please try again"];
            }
        }];
    }else{
       
        [Spotlight.instance spotlightChangeEnvironment:PRODUCTION onComplete:^(bool isSuccess, NSString *responseToken) {
            if(isSuccess){
                _barbuttonenvironment.tag = 1;
                [_barbuttonenvironment setTitle:@"Sandbox"];
                [self showMessage:@"Status" msg:@"Success change to PRODUCTION"];
            }else{
                [Spotlight.instance spotlightChangeEnvironment:SANDBOX onComplete:^(bool isSuccess, NSString *responseToken) {
                    if(isSuccess){;
                        [self showMessage:@"Status" msg:@"Success back to SANDBOX"];
                    }
                }];
                [self showMessage:@"Status" msg:@"Gagal Login please try again"];
            }
        }];
    }
    }else{
        [self showMessage:@"Status" msg:@"Please login first"];
    }
}


@end

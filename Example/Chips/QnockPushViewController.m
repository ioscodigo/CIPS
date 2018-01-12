//
//  QnockPushViewController.m
//  Chips
//
//  Created by Fajar on 12/13/17.
//  Copyright © 2017 fajaraw. All rights reserved.
//

#import "QnockPushViewController.h"


@interface QnockPushViewController ()

@end

@implementation QnockPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labelUnixID.text = [self.userInfo objectForKey:@"unix_id"];
    NSDictionary *alert = [[self.userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    self.labelTittle.text = [alert objectForKey:@"title"];
    self.labelMessage.text = [alert objectForKey:@"body"];
    self.labelData.text = [self.userInfo objectForKey:@"data"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dissmisOnClick:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end

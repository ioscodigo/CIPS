//
//  ChipsViewController.m
//  Chips
//
//  Created by fajaraw on 09/22/2017.
//  Copyright (c) 2017 fajaraw. All rights reserved.
//

#import "ChipsViewController.h"
#import <Cips/Cips.h>

@interface ChipsViewController ()

@end

@implementation ChipsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [Squad initWithClientId:@"1028948410f4662836" withClientSecret:@"f3752b5d0b7e308adba65b06aed0dc81"];
    [[Squad instance] loginWithEmail:@"leomastakusuma@gmail.com" andPassoword:@"Masta123" completion:^(SquadResponseModel *response) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

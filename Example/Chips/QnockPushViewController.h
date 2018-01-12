//
//  QnockPushViewController.h
//  Chips
//
//  Created by Fajar on 12/13/17.
//  Copyright © 2017 fajaraw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QnockPushViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelUnixID;
@property (weak, nonatomic) IBOutlet UILabel *labelTittle;
@property (weak, nonatomic) IBOutlet UILabel *labelMessage;
@property (weak, nonatomic) IBOutlet UILabel *labelData;

@property (strong,nonatomic) NSDictionary *userInfo;

@end

//
//  SpotlightStoryListViewController.h
//  Chips
//
//  Created by Fajar on 1/23/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cips/Cips.h>

@interface SpotlightStoryListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) bool isChannel;
@property (nonatomic,strong) NSString *channelName;


@end

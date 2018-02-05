//
//  SpotlightStoryDetailViewController.h
//  Chips_Example
//
//  Created by Fajar on 1/25/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Cips/Cips.h>

@interface SpotlightStoryDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *storyno;
@property (weak, nonatomic) IBOutlet UILabel *storyName;
@property (weak, nonatomic) IBOutlet UILabel *storyArticle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSString *story_no;

@end

//
//  HearsayCommentViewController.h
//  Chips_Example
//
//  Created by Fajar on 4/6/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HearsayCommentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelTotalComment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@protocol HearsayLoadMoreDelegate
-(void)LoadMoreOnClick;
@end

@interface HearsayLoadMoreCell:UITableViewCell

@property (nonatomic) id<HearsayLoadMoreDelegate> delegate;
@end

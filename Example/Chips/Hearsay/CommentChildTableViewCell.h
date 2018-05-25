//
//  CommentChildTableViewCell.h
//  Chips_Example
//
//  Created by Fajar on 4/11/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CommentChildTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightView;

@end

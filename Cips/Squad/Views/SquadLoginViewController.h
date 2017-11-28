//
//  SquadLoginViewController.h
//  Pods
//
//  Created by Fajar on 10/17/17.
//
//

#import <UIKit/UIKit.h>
#import "../SquadViewHelper.h"


@interface SquadLoginViewController : UIViewController

@property (nonatomic) id<SquadControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;

@end

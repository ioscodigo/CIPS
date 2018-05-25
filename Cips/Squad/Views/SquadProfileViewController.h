//
//  SquadProfileViewController.h
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import <UIKit/UIKit.h>

@interface SquadProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelEmail;
@property (weak, nonatomic) IBOutlet UILabel *labelBirthDate;
@property (weak, nonatomic) IBOutlet UILabel *labelBirthPlace;
@property (weak, nonatomic) IBOutlet UILabel *labelGender;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelCountry;
@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelZipCode;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;
@property (weak, nonatomic) IBOutlet UIImageView *imageCover;

@property (weak, nonatomic) NSString *accessToken;
@property (weak, nonatomic) NSString *userID;



@end

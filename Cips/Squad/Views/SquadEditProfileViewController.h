//
//  SquadEditProfileViewController.h
//  Pods
//
//  Created by Fajar on 11/1/17.
//
//

#import <UIKit/UIKit.h>

@interface SquadEditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *fieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *fieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;
@property (weak, nonatomic) IBOutlet UITextField *fieldBirthdayDay;
@property (weak, nonatomic) IBOutlet UITextField *fieldBirthdayMonth;
@property (weak, nonatomic) IBOutlet UITextField *fieldBirthdayYear;
@property (weak, nonatomic) IBOutlet UITextField *fieldBirthPlace;
@property (weak, nonatomic) IBOutlet UITextField *fieldBirthGender;
@property (weak, nonatomic) IBOutlet UITextField *fieldAddress;
@property (weak, nonatomic) IBOutlet UITextField *fieldCountry;
@property (weak, nonatomic) IBOutlet UITextField *fieldZipCode;
@property (weak, nonatomic) IBOutlet UITextField *fieldCity;
@property (weak, nonatomic) IBOutlet UITextField *fieldPhoneNumber;

@property (weak, nonatomic) NSString *accessToken;
@property (weak, nonatomic) NSString *userID;


@end

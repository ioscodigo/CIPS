//
//  SquadProfileViewController.h
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import <UIKit/UIKit.h>

@interface SquadProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *fieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *fieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldBirthdayDay;
@property (weak, nonatomic) IBOutlet UITextField *fieldBirthdayMonth;
@property (weak, nonatomic) IBOutlet UITextField *fieldBirthdayYear;
@property (weak, nonatomic) IBOutlet UITextField *fieldBirthdayPlace;
@property (weak, nonatomic) IBOutlet UITextField *fieldGender;
@property (weak, nonatomic) IBOutlet UITextField *fieldAddress;
@property (weak, nonatomic) IBOutlet UITextField *fieldCountry;
@property (weak, nonatomic) IBOutlet UITextField *fieldZipCode;
@property (weak, nonatomic) IBOutlet UITextField *fieldCity;

@end

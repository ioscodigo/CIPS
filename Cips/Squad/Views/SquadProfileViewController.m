//
//  SquadProfileViewController.m
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import "SquadProfileViewController.h"
#import "Cips/Cips.h"
#import <Cips/CIPS+NSDictionary.h>
#import "../SquadViewHelper.h"
#import "SquadEditProfileViewController.h"
#import "UIImageView+WebCache.h"

@interface SquadProfileViewController ()<UITextFieldDelegate>{
    SquadViewHelper *helper;
}
@end

@implementation SquadProfileViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    helper = [SquadViewHelper helper];
}

-(void)viewWillAppear:(BOOL)animated{
    _imageCover.layer.cornerRadius = _imageCover.frame.size.width / 2;
}

- (void)viewDidAppear:(BOOL)animated{
    [helper addLoading];
    [self loadDataProfile];
}

-(void)loadDataProfile{
    [Squad.instance userInfoGetWithToken:self.accessToken respon:^(SquadResponseModel *response) {
        [helper removeLoading];
        NSLog(@"%@",response.message);
        if(response.isSucces){
            NSDictionary *userData = [response.data objectForKey:@"user"];
            _labelName.text = [NSString stringWithFormat:@"%@ %@",[userData StringForKey:@"first_name"],[userData StringForKey:@"last_name"]];
            _labelEmail.text = [userData StringForKey:@"email"];
            _labelBirthDate.text = [userData StringForKey:@"birthdate"]; //01-januari-1897
            _labelBirthPlace.text = [userData StringForKey:@"birthplace"];
            _labelPhone.text = [userData StringForKey:@"phone_number"];
            _labelGender.text = [userData StringForKey:@"gender"];
            _labelAddress.text = [userData StringForKey:@"address"];
            _labelZipCode.text = [userData StringForKey:@"zip"];
//            _labelCity.text = [userData StringForKey:@"city"];
//            label
            NSString *photo = [userData StringForKey:@"photo"];
            if([photo length] > 1){
                [_imageCover sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"ico-profile"]];
            }
            if([[userData objectForKey:@"country"] objectForKey:@"_id"] != nil){
                _labelCity.text = [[userData objectForKey:@"city"] objectForKey:@"_name"];
            }
            if([[userData objectForKey:@"country"] objectForKey:@"_id"] != nil){
                _labelCountry.text = [[userData objectForKey:@"country"] objectForKey:@"_name"];
            }
            self.userID = [userData StringForKey:@"user_id"];
            
        }else{
            NSLog(@"Profile Failed %@",response.display_message);
        }
    }];
}

- (IBAction)squadeditProfileOnClick:(id)sender {
    SquadEditProfileViewController *editProfile = [self.storyboard instantiateViewControllerWithIdentifier:@"editProfileVC"];
    editProfile.accessToken = self.accessToken;
    editProfile.userID = self.userID;
    [self.navigationController pushViewController:editProfile animated:true];
}

- (IBAction)squadDismissOnClick:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end

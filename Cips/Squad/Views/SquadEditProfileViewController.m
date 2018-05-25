//
//  SquadEditProfileViewController.m
//  Pods
//
//  Created by Fajar on 11/1/17.
//
//

#import "SquadEditProfileViewController.h"
#import "SquadChangeEmailViewController.h"
#import "SquadChangePasswordViewController.h"
#import <Cips/CIPS+NSDictionary.h>
#import "Cips/Cips.h"
#import "../SquadViewHelper.h"
#import "UIImageView+WebCache.h"
#import "TPKeyboardAvoiding/UIScrollView+TPKeyboardAvoidingAdditions.h"
#import <Photos/Photos.h>


typedef void (^CaseBlock)();

@interface SquadEditProfileViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>{
    NSArray *listCountry;
    NSArray *listCity;
    NSArray *listGender;
    NSArray *listPicker;
    
    NSString *countryid;
    NSString *cityid;
    NSString *genderid;
    int typeShow;
    
    NSArray *listField;
}
@property (weak, nonatomic) IBOutlet UIView *viewKeyboard;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewHolderPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *viewPicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonGender;
@property (weak, nonatomic) IBOutlet UIButton *buttonCountry;
@property (weak, nonatomic) IBOutlet UIButton *buttonCity;
@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightPhoneNumber;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightBirthPlace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightGender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightAddress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightCountry;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightZipcode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightCity;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightBirthday;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightName;



@end

@implementation SquadEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countryid = @"0";
    cityid = @"0";
    listGender = @[@{@"_name":@"Male",@"_id":@"2"},@{@"_name":@"Female",@"_id":@"1"}];
    listPicker = @[];
    _viewPicker.delegate = self;
    _viewPicker.dataSource = self;
    typeShow = -1;
    genderid = @"2";
    _fieldBirthGender.text = @"Male";
    _fieldBirthdayDay.delegate = self;
    _fieldBirthdayMonth.delegate = self;
    _fieldBirthdayYear.delegate = self;
    [self getListCountry];
    // Do any additional setup after loading the view.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSCharacterSet *notDigit = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSCharacterSet *validChars = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet];
    bool allDigit = [textField.text rangeOfCharacterFromSet:notDigit].location == NSNotFound;
    bool isDigit = [string rangeOfCharacterFromSet:notDigit].location == NSNotFound;
    bool isChar = [string rangeOfCharacterFromSet:validChars].location == NSNotFound;
    NSLog(@" bool %d, %d, %d",allDigit,isChar,isDigit);
    if([string isEqualToString:@""]){
        return true;
    }
    if (allDigit && isDigit) {
        int count = [textField.text intValue];
        int next = [string intValue];
        if(textField == _fieldBirthdayDay){
            if(textField.text.length >= 2){
                return false;
            }
            if (count > 32){
                return false;
            }
            if (count == 3) {
                return next < 2;
            }
            return count < 4;
        }
        if(textField == _fieldBirthdayMonth){
            if(textField.text.length >= 2){
                return false;
            }
            if (count == 1){
                return next < 3;
            }
            return count == 0;
        }
        if(textField == _fieldBirthdayYear) {
            if(textField.text.length >= 4){
                return false;
            }
            
            return count < 210;
        }
    }
    return true;
}

-(void)viewWillAppear:(BOOL)animated{
    _imageProfile.layer.cornerRadius = _imageProfile.frame.size.height / 2;
    [self getEditProfile];
}

-(void)getListCountry{
    [Squad.instance getListCountry:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            listCountry = [response.data objectForKey:@"country"];
        }else{
            NSLog(@"country %@",response.display_message);
        }
    }];
}

-(void)getListCity{
    [Squad.instance getListCityWithCountryId:countryid respon:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            listCity = [response.data objectForKey:@"city"];
        }
    }];
}

- (IBAction)squadEditProfilePicture:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Delete Photo" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getPhoto:true];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getPhoto:false];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:true completion:nil];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

- (IBAction)squadBackEditProfie:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}
- (IBAction)squadUpdateAccount:(id)sender {
    [self setDataEdit];
}
- (IBAction)squadShowChangeEmailAddress:(id)sender {
    SquadChangeEmailViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"changeEmailVC"];
    controller.accessToken = self.accessToken;
    controller.userID = self.userID;
    [self.navigationController pushViewController:controller animated:true];
}
- (IBAction)squadShowChangePassword:(id)sender {
    SquadChangePasswordViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"changePasswordVC"];
    controller.userID = self.userID;
    controller.accessToken = self.accessToken;
    [self.navigationController pushViewController:controller animated:true];
}
- (IBAction)squadChangeGender:(id)sender {
    typeShow = 0;
    listPicker = listGender;
    [_viewHolderPicker setHidden:false];
    [_viewPicker reloadAllComponents];
//    [_viewPicker selectRow:<#(NSInteger)#> inComponent:<#(NSInteger)#> animated:<#(BOOL)#>]
}
- (IBAction)squadChangeCountry:(id)sender {
    typeShow = 1;
    listPicker = listCountry;
    [_viewHolderPicker setHidden:false];
    [_viewPicker reloadAllComponents];
}
- (IBAction)squadChangeCity:(id)sender {
    typeShow = 2;
    listPicker = listCity;
    [_viewHolderPicker setHidden:false];
    [_viewPicker reloadAllComponents];
}
- (IBAction)closePicker:(id)sender {
    if(typeShow == 1){
        [self getListCity];
    }
    [_viewHolderPicker setHidden:true];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(row == 0){
        return @"--";
    }else{
        return [listPicker[row-1] objectForKey:@"_name"];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"picker row %ld",row);
    if(row > 0 ){
        NSDictionary *data = listPicker[row-1];
        switch (typeShow) {
            case 0:
                _fieldBirthGender.text = [data objectForKey:@"_name"];
                genderid = [data objectForKey:@"_id"];
                break;
            case 1:
                _fieldCountry.text = [data objectForKey:@"_name"];
                countryid = [data objectForKey:@"_id"];
                
                break;
            case 2:
                _fieldCity.text = [data objectForKey:@"_name"];
                cityid = [data objectForKey:@"_id"];
                break;
            default:
                break;
        }
    }
}

-(void)setDataEdit{
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithDictionary:@{@"access_token":_accessToken,@"user_id":_userID}];
    if(_fieldPhoneNumber.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"phone_number":_fieldPhoneNumber.text}];
    }
    if(_fieldFirstName.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"first_name":_fieldFirstName.text}];
    }
    if(_fieldLastName.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"last_name":_fieldLastName.text}];
    }
    if(_fieldBirthPlace.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"birthplace":_fieldBirthPlace.text}];
    }
    if(_fieldAddress.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"address":_fieldAddress.text}];
    }
    if(_buttonCountry.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"country":countryid}];
    }
    if(_buttonCity.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"city":cityid}];
    }
    if(_fieldZipCode.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"zip":_fieldZipCode.text}];
    }
    if(_buttonGender.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"gender":genderid}];
    }
    [tempDict addEntriesFromDictionary:@{@"birthdate":[NSString stringWithFormat:@"%@-%@-%@",_fieldBirthdayYear.text,_fieldBirthdayMonth.text,_fieldBirthdayDay.text]}];
    [Squad.instance profileEditWithData:tempDict respon:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            [SquadViewHelper.helper showMessage:response.display_message status:SUCCESS];
            [self getEditProfile];
        }else{
            [SquadViewHelper.helper showMessage:response.display_message status:ERROR];
        }
    }];
}

-(void)getEditProfile{
    [Squad.instance resourceWithParamsGetWithToken:_accessToken respon:^(SquadResponseModel *response) {
        if(response.isSucces){
            NSDictionary *userData = [response.data objectForKey:@"user"];
            self.fieldFirstName.text = [userData StringForKey:@"first_name"];
            self.fieldLastName.text = [userData StringForKey:@"last_name"];
            self.fieldEmail.text = [userData StringForKey:@"email"];
//            _fieldBirthGender.text = [userData StringForKey:@"gender"];
            self.fieldAddress.text = [userData StringForKey:@"address"];
            self.fieldZipCode.text = [userData StringForKey:@"zip"];
            self.fieldBirthPlace.text = [userData StringForKey:@"birthplace"];
            self.fieldPhoneNumber.text = [userData StringForKey:@"phone_number"];
            if([[userData objectForKey:@"country"] objectForKey:@"_id"] != nil){
                cityid = [[userData objectForKey:@"city"] objectForKey:@"_id"];
                self.fieldCity.text = [[userData objectForKey:@"city"] objectForKey:@"_name"];
            }
            if([[userData objectForKey:@"country"] objectForKey:@"_id"] != nil){
                countryid = [[userData objectForKey:@"country"] objectForKey:@"_id"];
                self.fieldCountry.text = [[userData objectForKey:@"country"] objectForKey:@"_name"];
            }
            if([[userData StringForKey:@"gender"] length] > 0){
                genderid = [userData StringForKey:@"gender"];
                if([genderid isEqualToString:@"2"]){
                    self.fieldBirthGender.text = @"Male";
                }else{
                    self.fieldBirthGender.text = @"Female";
                }
            }
            NSString *photo = [userData StringForKey:@"photo"];
            if([photo length] > 1){
                [self.imageProfile sd_setImageWithURL:[NSURL URLWithString:photo] placeholderImage:[UIImage imageNamed:@"ico-profile"]];
            }
            self.userID = [userData StringForKey:@"user_id"];
            self.fieldBirthGender.text = [self.userID isEqualToString:@"1"] ? @"female" : @"male";
            NSArray *birthDate = [[userData StringForKey:@"birthdate"] componentsSeparatedByString:@"-"];
            if(birthDate.count > 2) {
                self.fieldBirthdayYear.text = birthDate[0];
                self.fieldBirthdayMonth.text = birthDate[1];
                self.fieldBirthdayDay.text = birthDate[2];
            }
            [self disableView:userData];
        }else{
            NSLog(@"Profile Failed %@",response.display_message);
        }
    }];
}


-(void)disableView:(NSDictionary *)item{
    NSDictionary *d = @{
                        @"phone_number":
                            ^{
                                [self.fieldPhoneNumber setEnabled:true];
                                [self.fieldPhoneNumber.superview setHidden:false];
                                _constraintHeightPhoneNumber.constant = 50;
                            },
                        @"gender":
                            ^{
                                [self.buttonGender setEnabled:true];
                                [_fieldBirthGender.superview setHidden:false];
                                _constraintHeightGender.constant = 50;
                            },
                        @"birthdate":
                            ^{ 
                                [_fieldBirthdayDay setEnabled:true];
                                [_fieldBirthdayMonth setEnabled:true];
                                [_fieldBirthdayYear setEnabled:true];
                                [_fieldBirthdayDay.superview setHidden:false];
                                [_fieldBirthdayMonth.superview setHidden:false];
                                [_fieldBirthdayYear.superview setHidden:false];
                                _constraintHeightBirthday.constant = 50;
                            },
                        @"birthplace":
                            ^{ 
                                 [_fieldBirthPlace setEnabled:true];
                                _fieldBirthPlace.superview.hidden = false;
                                _constraintHeightBirthPlace.constant = 50;
                            },
                        @"city":
                            ^{
                                [_buttonCity setEnabled:true];
                                _fieldCity.superview.hidden = false;
                                _constraintHeightCity.constant = 50;
                                
                            },
                        @"country":
                            ^{
                                [_buttonCountry setEnabled:true];
                                _fieldCountry.superview.hidden = false;
                                _constraintHeightCountry.constant = 50;
                            },
                        @"zip":
                            ^{
                                [_fieldZipCode setEnabled:true];
                                _fieldZipCode.superview.hidden = false;
                                _constraintHeightZipcode.constant = 50;
                            },
                        @"address":
                            ^{
                                [_fieldAddress setEnabled:true];
                                _fieldAddress.superview.hidden = false;
                                _constraintHeightAddress.constant = 50;
                            },
                        @"first_name":
                            ^{
                                [_fieldFirstName setEnabled:true];
                                _fieldFirstName.superview.hidden = false;
                                _constraintHeightName.constant = 50;
                            },
                        @"last_name":
                            ^{
                                [_fieldLastName setEnabled:true];
                                _fieldLastName.superview.hidden = false;
                                _constraintHeightName.constant = 50;
                            }
                        };
    for (NSString *keys in [item allKeys]) {
        if(d[keys] != nil){
            ((CaseBlock)d[keys])();
        }
    }
}

-(void)getPhoto:(BOOL)fromCamera{
    SquadViewHelper *helper = [SquadViewHelper helper];
    switch ([PHPhotoLibrary authorizationStatus]) {
        case PHAuthorizationStatusAuthorized:
            [self authorize:fromCamera];
            break;
        case PHAuthorizationStatusNotDetermined:{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if(status == PHAuthorizationStatusAuthorized){
                    [self authorize:fromCamera];
                }else{
                    [helper showMessage:@"It is not determined until now" status:ERROR];
                }
            }];
            break;
        }
        case PHAuthorizationStatusRestricted:
            [helper showMessage:@"User do not have access to photo album or camera." status:ERROR];
            break;
        case PHAuthorizationStatusDenied:
            [helper showMessage:@"User has denied the permission." status:ERROR];
            break;
        default:
            break;
    }
    
}

-(void)authorize:(BOOL)fromCamera{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.allowsEditing = true;
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
    controller.sourceType = fromCamera ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:controller animated:true completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"image size %lul",[UIImageJPEGRepresentation(image, 0.5) length]);
    if(image){
    [picker dismissViewControllerAnimated:true completion:^{
        [SquadViewHelper.helper addLoading];
        [Squad.instance uploadImage:UIImageJPEGRepresentation(image, 0.6) userid:_userID accessToken:_accessToken respon:^(SquadResponseModel *response) {
            [SquadViewHelper.helper removeLoading];
            if([response.status isEqualToString:@"200"]){
                NSLog(@"%@",response.message);
                NSLog(@"%@",response.data);
                [SquadViewHelper.helper showMessage:response.display_message status:SUCCESS];
                [self getEditProfile];
            }else{
                [SquadViewHelper.helper showMessage:response.display_message status:ERROR];
            }
        }];
    }];
    }
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return listPicker.count + 1;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

@end

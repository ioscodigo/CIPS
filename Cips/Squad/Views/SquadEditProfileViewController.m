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

typedef void (^CaseBlock)();

@interface SquadEditProfileViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
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

@end

@implementation SquadEditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countryid = @"0";
    cityid = @"0";
    listGender = @[@{@"_name":@"Male",@"_id":@"male"},@{@"_name":@"Female",@"_id":@"female"}];
    listPicker = @{};
    _viewPicker.delegate = self;
    _viewPicker.dataSource = self;
    typeShow = -1;
    genderid = @"female";
    [self getListCountry];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getEditProfile];
}

-(void)getListCountry{
    [Squad.instance getListCountry:^(SquadResponseModel *response) {
        if([response.status isEqualToString:@"200"]){
            listCountry = [response.data objectForKey:@"country"];
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
    if(_fieldBirthGender.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"gender":_fieldBirthGender.text}];
    }
    if(_fieldAddress.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"address":_fieldAddress.text}];
    }
    if(_fieldCountry.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"country":countryid}];
    }
    if(_fieldCity.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"city":cityid}];
    }
    if(_fieldZipCode.isEnabled){
        [tempDict addEntriesFromDictionary:@{@"zip":_fieldZipCode.text}];
    }
    [tempDict addEntriesFromDictionary:@{@"birthdate":[NSString stringWithFormat:@"%@-%@-%@",_fieldBirthdayYear.text,_fieldBirthdayMonth.text,_fieldBirthdayDay.text]}];
    
    [Squad.instance profileEditWithData:tempDict respon:^(SquadResponseModel *response) {
        NSLog(@"respone %@",response.display_message);
        NSLog(@"data %@",response.data);
        if([response.status isEqualToString:@"200"]){
            [SquadViewHelper.helper showMessage:response.display_message status:SUCCESS];
        }else{
            [SquadViewHelper.helper showMessage:response.display_message status:ERROR];
        }
    }];
}

-(void)getEditProfile{
    [Squad.instance resourceWithParamsGetWithToken:_accessToken respon:^(SquadResponseModel *response) {
        if(response.isSucces){
            NSDictionary *userData = [response.data objectForKey:@"user"];
            _fieldFirstName.text = [userData StringForKey:@"first_name"];
            _fieldLastName.text = [userData StringForKey:@"last_name"];
            _fieldEmail.text = [userData StringForKey:@"email"];
//            _fieldBirthGender.text = [userData StringForKey:@"gender"];
            _fieldAddress.text = [userData StringForKey:@"address"];
            _fieldZipCode.text = [userData StringForKey:@"zip"];
            _fieldBirthPlace.text = [userData StringForKey:@"birthplace"];
            _fieldPhoneNumber.text = [userData StringForKey:@"phone_number"];
            if([[userData objectForKey:@"country"] objectForKey:@"_id"] != nil){
                cityid = [[userData objectForKey:@"city"] objectForKey:@"_id"];
                _fieldCity.text = [[userData objectForKey:@"city"] objectForKey:@"_name"];
            }
            if([[userData objectForKey:@"country"] objectForKey:@"_id"] != nil){
                countryid = [[userData objectForKey:@"country"] objectForKey:@"_id"];
                _fieldCountry.text = [[userData objectForKey:@"country"] objectForKey:@"_name"];
            }
            genderid = [userData StringForKey:@"gender"];
            self.userID = [userData StringForKey:@"user_id"];
            _fieldBirthGender.text = [self.userID isEqualToString:@"1"] ? @"female" : @"male";
            NSArray *birthDate = [[userData StringForKey:@"birthdate"] componentsSeparatedByString:@"-"];
            if(birthDate.count > 2) {
                _fieldBirthdayYear.text = birthDate[0];
                _fieldBirthdayMonth.text = birthDate[1];
                _fieldBirthdayDay.text = birthDate[2];
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
                                [_fieldPhoneNumber setEnabled:true];
                                [_fieldPhoneNumber setPlaceholder:@"Phone Number"];
                            },
                        @"gender":
                            ^{
                                [_fieldBirthGender setEnabled:true];
                                [_fieldBirthGender setPlaceholder:@"Gender"];
                                [_buttonGender setEnabled:true];
                            },
                        @"birthdate":
                            ^{ 
                                [_fieldBirthdayDay setEnabled:true];
                                [_fieldBirthdayMonth setEnabled:true];
                                [_fieldBirthdayYear setEnabled:true];
                            },
                        @"birthplace":
                            ^{ 
                                 [_fieldBirthPlace setEnabled:true];
                                [_fieldBirthPlace setPlaceholder:@"Birth Place"];
                            },
                        @"city":
                            ^{
//                                [_fieldCity setEnabled:true];
                                [_fieldCity setPlaceholder:@"City"];
                                [_buttonCity setEnabled:true];
                                
                            },
                        @"country":
                            ^{
//                                [_fieldCountry setEnabled:true];
                                [_fieldCountry setPlaceholder:@"Country"];
                                [_buttonCountry setEnabled:true];
                            },
                        @"zip":
                            ^{
                                [_fieldZipCode setEnabled:true];
                                [_fieldZipCode setPlaceholder:@"ZIP Code"];
                            },
                        @"address":
                            ^{
                                [_fieldAddress setEnabled:true];
                                [_fieldAddress setPlaceholder:@"Address"];
                            },
                        @"first_name":
                            ^{
                                [_fieldFirstName setEnabled:true];
                            },
                        @"last_name":
                            ^{
                                [_fieldLastName setEnabled:true];
                            }
                        };
    for (NSString *keys in [item allKeys]) {
        if(d[keys] != nil){
            ((CaseBlock)d[keys])();
        }
    }
}

-(void)getPhoto:(BOOL)fromCamera{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.allowsEditing = true;
    controller.sourceType = fromCamera ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:controller animated:true completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"info %@",[info allKeys]);
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:true completion:^{
        [SquadViewHelper.helper addLoading];
    }];
    [Squad.instance uploadImage:UIImageJPEGRepresentation(image, 0.6) userid:_userID accessToken:_accessToken respon:^(SquadResponseModel *response) {
        [SquadViewHelper.helper removeLoading];
        if([response.status isEqualToString:@"200"]){
            [SquadViewHelper.helper showMessage:response.display_message status:SUCCESS];
        }else{
            [SquadViewHelper.helper showMessage:response.display_message status:SUCCESS];
        }
    }];
}


-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return listPicker.count + 1;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

@end

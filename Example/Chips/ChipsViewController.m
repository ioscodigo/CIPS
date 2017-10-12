//
//  ChipsViewController.m
//  Chips
//
//  Created by fajaraw on 09/22/2017.
//  Copyright (c) 2017 fajaraw. All rights reserved.
//

#import "ChipsViewController.h"
#import <Cips/Cips.h>
#import <Photos/Photos.h>

@interface ChipsViewController ()

@end

@implementation ChipsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [Squad initWithClientId:@"1028948410f4662836" withClientSecret:@"f3752b5d0b7e308adba65b06aed0dc81"];
//    [[Squad instance] loginWithEmail:@"leomastakusuma@gmail.com" andPassoword:@"Masta123" completion:^(SquadResponseModel *response) {
//        
//    }];
//    [Squ]
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)iamgePicker{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:NO completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    NSLog(@"iamge %@",[info allKeys]);
    PHFetchResult * result = [PHAsset fetchAssetsWithALAssetURLs:@[info[@"UIImagePickerControllerReferenceURL"]] options:nil];
    
    [PHImageManager.defaultManager requestImageDataForAsset:result.firstObject options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        NSDictionary *param = @{
                                @"image_upload":imageData,
                                @"user_id":@"1",
                                @"access_token":@"e2b194d1ecd62705c26773d9cd4fdb48ab9d2da1"
                                };
        [[Squad instance] uploadImageWithParam:param respon:^(SquadResponseModel *response) {
            [self response:response];
        }];
    }];
}

-(void)editProfile{
    
    NSDictionary *param = @{
                            @"access_token":@"e2b194d1ecd62705c26773d9cd4fdb48ab9d2da1",
                            @"user_id":@"1",
                            @"birthdate":@"1990-06-24"
                            };
    [[Squad instance] profileEditWithData:param respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}
-(void)registerEmail{
    [[Squad instance] registerFirstWithEmail:@"squadtest@mailhog.codigo.id" password:@"Test1234" fullname:@"abcd" companyid:@"2" redirecturi:@"a" verifyuri:@"a" completion:^(SquadResponseModel *response) {
        NSLog(response.display_message);
    }];
}

-(void)verificationRegister{
    [[Squad instance] verificationRegisterWithUserid:@"" code:@"" redirect:@"" respon:^(SquadResponseModel *response) {
        
    }];
}

-(void)getUserinfo{
    [[Squad instance] userInfoGetWithToken:@"c822a43cfefe384268ec74e93f3bbb96433d836b" respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}

-(void)refreshToken{
    [[Squad instance] tokenRefreshWithToken:@"d12450698d1b03fdd78d5e703926b5289101d4e1" respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}

-(void)logout{
    [[Squad instance] logoutAccessToken:@"37fc65d6fa030ff77ace27321632e8ac0ede9585" refreshToken:@"e6b427c7c040c0bdee12f5c3b7d3515c6a19e2ac" respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}

-(void)getResource{
    [[Squad instance] resourceWithParamsGetWithToken:@"f8b65b9cc9d6ab0a73178a3aaad7ceb10f2ff46a" respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}

-(void)verifyEmail{
    [[Squad instance] emailVerifyWithUserid:@"169" verificationCode:@"6808a08c551370ed1950113b5d162457" respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}

-(void)updateEmail{
    [[Squad instance] emailUpdateWithAccessToken:@"" userid:@"" newEmail:@"" password:@"" respon:^(SquadResponseModel *response) {
        
    }];
}

-(void)checkPassword{
    [[Squad instance] passwordCheckWithUserid:@"1" password:@"Masta123" respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}

-(void)resendRegisterVerification{
    [[Squad instance] registerVerificationResendWithUserid:@"170" respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}

-(void)registerVerification{
    [[Squad instance] verificationRegisterWithUserid:@"170" code:@"6b1ba1245b49d074f5fc26f99e5ec2cb" redirect:@"a" respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}

-(void)updatePassword{
    [[Squad instance] passwordUpdateWithAccessToken:@"" userid:@"" oldPassword:@"" newPassword:@"" respon:^(SquadResponseModel *response) {
        [self response:response];
    }];
}

-(void)response:(SquadResponseModel *)response{
    NSLog(@"code :%d",response.statusCode);
    NSLog(@"messeage: %@",response.message);
    NSLog(@"display_message: %@",response.display_message);
    NSLog(@"data %@",response.data);
}

@end

//
//  SquadProfile.h
//  Pods
//
//  Created by Fajar on 9/27/17.
//
//

#import <Foundation/Foundation.h>

@interface SquadProfile : NSObject

@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *fullname;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) NSString *birthdate;
@property (nonatomic) BOOL isVerified;
@property (nonatomic,strong) NSString *companyID;
@property (nonatomic,strong) NSString *joinDate;



@end

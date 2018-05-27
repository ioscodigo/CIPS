//
//  HearsayResponseModel.h
//  Bolts
//
//  Created by Fajar on 4/2/18.
//

#import <Foundation/Foundation.h>

@interface HearsayResponseModel : NSObject
@property (nonatomic,strong) NSString* status;
@property (nonatomic,strong) NSError *error;
@property (nonatomic) BOOL isSuccess;
@property (nonatomic,strong) NSString* message;
@property (nonatomic,strong) NSString* display_message;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSDictionary *data;
@end

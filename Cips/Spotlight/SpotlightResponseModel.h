//
//  SpotlightResponseModel.h
//  Pods
//
//  Created by Fajar on 1/8/18.
//
//

#import <Foundation/Foundation.h>

@interface SpotlightResponseModel : NSObject

@property (nonatomic,strong) NSString* status;
@property (nonatomic,strong) NSError *error;
@property (nonatomic) BOOL isSucces;
//@property (nonatomic) int statusCode;
@property (nonatomic,strong) NSString* message;
@property (nonatomic,strong) NSString* display_message;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSDictionary *data;

@end

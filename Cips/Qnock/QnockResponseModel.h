//
//  QnockResponseModel.h
//  Pods
//
//  Created by Calista on 10/2/17.
//
//

#import <Foundation/Foundation.h>

@interface QnockResponseModel : NSObject

@property (nonatomic,strong) NSString* status;
@property (nonatomic,strong) NSError *error;
@property (nonatomic) BOOL isSucces;
//@property (nonatomic) int statusCode;
@property (nonatomic,strong) NSString* message;
@property (nonatomic,strong) NSString* display_message;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSDictionary *data;

@end

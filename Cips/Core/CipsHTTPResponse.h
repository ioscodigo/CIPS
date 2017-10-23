//
//  ResponseModel.h
//  Pods
//
//  Created by Fajar on 9/25/17.
//
//

#import <Foundation/Foundation.h>

@interface CipsHTTPResponse : NSObject

@property (nonatomic) int responseCode;
@property (nonatomic,strong) NSError *error;
@property (nonatomic,strong) NSDictionary *data;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *responString;
//@property (nonatomic,strong) NS

@end

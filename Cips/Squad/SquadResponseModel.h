//
//  SquadResponseModel.h
//  Pods
//
//  Created by Fajar on 9/26/17.
//
//

#import <Foundation/Foundation.h>

@interface SquadResponseModel : NSObject

@property (nonatomic,strong) NSString* status;
@property (nonatomic,strong) NSError *error;
@property (nonatomic) BOOL isSucces;
@property (nonatomic) int statusCode;
@property (nonatomic,strong) NSString* message;
@property (nonatomic,strong) NSString* display_message;
@property (nonatomic,strong) NSDictionary *data;
@end

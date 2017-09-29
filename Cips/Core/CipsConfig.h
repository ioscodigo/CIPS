//
//  ChipsConfig.h
//  Pods
//
//  Created by Fajar on 9/26/17.
//
//

#import <Foundation/Foundation.h>
#import "CipsHTTPHelper.h"


@interface Cips : NSObject

@property (nonatomic) ENVIRONMENT env;

+(Cips *)instance;

@end

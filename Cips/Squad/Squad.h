//
//  Squad.h
//  Pods
//
//  Created by Fajar on 9/22/17.
//
//

#import <Foundation/Foundation.h>
#import "SquadResponseModel.h"
#import "Cips/CipsHTTPHelper.h"

typedef void (^squadCompletion)(SquadResponseModel *response);

@interface Squad : NSObject

@property (nonatomic,strong) NSString *clientID;
@property (nonatomic,strong) NSString *clientSecret;

-(instancetype)init __attribute__((unavailable("init not available")));

+(Squad *)instance;
+(void)initWithClientId:(NSString *)clientID withClientSecret:(NSString *)clientSecret;
-(void)loginWithEmail:(NSString *)email andPassoword:(NSString *)password completion:(squadCompletion)respon;

@end

//
//  SquadViewHelper.h
//  Pods
//
//  Created by Fajar on 10/12/17.
//
//

#import <Foundation/Foundation.h>

#import "SquadLoginViewController.h"
#import "SquadRegisterViewController.h"
#import "StatusView.h"

@protocol SquadControllerDelegate

@optional
-(void)squadLoginResponse:(NSDictionary *)data status:(BOOL)isSuccees message:(NSString *)message controller:(SquadLoginViewController *)controller;

@optional
-(void)squadRegisterResponse:(NSDictionary *)data status:(BOOL)isSuccess message:(NSString *)message controller:(SquadRegisterViewController *)controller;

@end

@interface SquadViewHelper : NSObject

-(UIViewController *)viewController;

@end

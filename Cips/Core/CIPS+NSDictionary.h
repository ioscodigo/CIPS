//
//  CIPS+NSDictionary.h
//  Pods
//
//  Created by Fajar on 11/1/17.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary(CIPS)

-(NSString *)StringForKey:(NSString *)key;
-(BOOL)BoolForKey:(NSString *)key;
-(NSDictionary *)dictionaryForKey:(NSString *)key;

@end

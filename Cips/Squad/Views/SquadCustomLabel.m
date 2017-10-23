//
//  SquadCustomLabel.m
//  Pods
//
//  Created by Fajar on 10/18/17.
//
//

#import "SquadCustomLabel.h"

@implementation SquadCustomLabel


-(void)setCharacterSpacing:(CGFloat)characterSpacing{
    if(characterSpacing > 0){
        NSDictionary *attributed = @{
                                     NSKernAttributeName : @(characterSpacing),
                                     NSFontAttributeName : self.font
                                     };
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.text attributes:attributed];
        self.attributedText = attrString;
    }
}

@end

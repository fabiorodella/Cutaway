//
//  UIStoryboard+RDLCutaway.h
//  Pods
//
//  Created by Fabio Rodella on 6/9/15.
//
//

#import <UIKit/UIKit.h>

@interface UIStoryboard (Cutaway)

+ (NSString *)cutaway_identifierPrefix;

+ (void)cutaway_setIdentifierPrefix:(NSString *)prefix;

@end

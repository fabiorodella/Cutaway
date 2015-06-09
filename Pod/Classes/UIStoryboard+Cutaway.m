//
//  UIStoryboard+RDLCutaway.m
//  Pods
//
//  Created by Fabio Rodella on 6/9/15.
//
//

#import "UIStoryboard+Cutaway.h"

#import <objc/runtime.h>

static NSString *cutaway_identifierPrefix = @"cutaway";

@implementation UIStoryboard (Cutaway)

#pragma mark - Superclass methods

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelector = @selector(instantiateViewControllerWithIdentifier:);
        SEL swizzledSelector = @selector(cutaway_instantiateViewControllerWithIdentifier:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Swizzled methods

- (id)cutaway_instantiateViewControllerWithIdentifier:(NSString *)identifier
{
    if ([identifier hasPrefix:cutaway_identifierPrefix]) {
        
        NSArray *components = [identifier componentsSeparatedByString:@"."];
        
        NSAssert([components count] == 3, @"Cutaway storyboard identifiers should be in the format '%@.StoryboardName.SceneID'", cutaway_identifierPrefix);
        
        NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *storyboardName = [components[1] stringByTrimmingCharactersInSet:whitespaceSet];
        NSString *viewControllerId = [components[2] stringByTrimmingCharactersInSet:whitespaceSet];
        
        NSAssert([storyboardName length] > 0, @"Cutaway storyboard name cannot be empty");
        NSAssert([viewControllerId length] > 0, @"Cutaway view controller ID cannot be empty");
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName
                                                             bundle:nil];
        
        return [storyboard instantiateViewControllerWithIdentifier:viewControllerId];
    }
    
    return [self cutaway_instantiateViewControllerWithIdentifier:identifier];
}

#pragma mark - Class methods

+ (NSString *)cutaway_identifierPrefix
{
    return cutaway_identifierPrefix;
}

+ (void)cutaway_setIdentifierPrefix:(NSString *)prefix
{
    cutaway_identifierPrefix = prefix;
}

@end

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

#pragma mark - Swizzling functions

static id cutaway_instantiateViewControllerWithIdentifier(id self, SEL _cmd, NSString *identifier);
static id (*cutaway_instantiateViewControllerWithIdentifierIMP)(id self, SEL _cmd, NSString *identifier);

static id cutaway_instantiateViewControllerWithIdentifier(id self, SEL _cmd, NSString *identifier) {

    if ([identifier hasPrefix:cutaway_identifierPrefix]) {
        
        NSArray *components = [identifier componentsSeparatedByString:@"_"];
        
        NSAssert([components count] == 3, @"Cutaway storyboard identifiers should be in the format '%@.StoryboardName.SceneID'", cutaway_identifierPrefix);
        
        NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *storyboardName = [components[1] stringByTrimmingCharactersInSet:whitespaceSet];
        NSString *viewControllerId = [components[2] stringByTrimmingCharactersInSet:whitespaceSet];
        
        NSAssert([storyboardName length] > 0, @"Cutaway storyboard name cannot be empty");
        NSAssert([viewControllerId length] > 0, @"Cutaway view controller ID cannot be empty");
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName
                                                             bundle:nil];
        
        return cutaway_instantiateViewControllerWithIdentifierIMP(storyboard, _cmd, viewControllerId);
    }
    
    return cutaway_instantiateViewControllerWithIdentifierIMP(self, _cmd, identifier);
}

#pragma mark - Category implementation

@implementation UIStoryboard (Cutaway)

#pragma mark - Superclass methods

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        IMP imp = NULL;
        IMP *store = (IMP *)&cutaway_instantiateViewControllerWithIdentifierIMP;
        
        SEL originalSelector = @selector(instantiateViewControllerWithIdentifier:);
        
        Method method = class_getInstanceMethod(self, originalSelector);
        
        if (method) {
            
            const char *type = method_getTypeEncoding(method);
            
            imp = class_replaceMethod(self, originalSelector, (IMP)cutaway_instantiateViewControllerWithIdentifier, type);
            
            if (!imp) {
                
                imp = method_getImplementation(method);
            }
        }
        
        if (imp) {
            
            *store = imp;
        }
    });
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

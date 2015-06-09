//
//  CutawayTests.m
//  CutawayTests
//
//  Created by Fabio Rodella on 06/09/2015.
//  Copyright (c) 2015 Fabio Rodella. All rights reserved.
//

// https://github.com/Specta/Specta

@import UIKit;

#import <Cutaway/Cutaway.h>

SpecBegin(UIStoryboard_Cutaway)

__block UINavigationController *navigationController = nil;
__block UIViewController *mainViewController = nil;

describe(@"identifier validation", ^{
    
    beforeEach(^{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Failures"
                                                             bundle:nil];
        
        navigationController = [storyboard instantiateInitialViewController];
        
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        
        window.rootViewController = navigationController;
        
        mainViewController = navigationController.topViewController;
    });
    
    it(@"will fail with incomplete identifier", ^{
        
        expect(^{
        
            [mainViewController performSegueWithIdentifier:@"showIncompleteIdentifier"
                                                    sender:nil];
        }).to.raiseAny();
    });
    
    it(@"will fail with invalid storyboard name", ^{
        
        expect(^{
            
            [mainViewController performSegueWithIdentifier:@"showInvalidStoryboardName"
                                                    sender:nil];
        }).to.raiseAny();
    });
    
    it(@"will fail with invalid view controller ID", ^{
        
        expect(^{
            
            [mainViewController performSegueWithIdentifier:@"showInvalidViewControllerID"
                                                    sender:nil];
        }).to.raiseAny();
    });
});

describe(@"storyboard linking", ^{
    
    beforeEach(^{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle:nil];
        
        navigationController = [storyboard instantiateInitialViewController];
        
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        
        window.rootViewController = navigationController;
        
        mainViewController = navigationController.topViewController;
    });
    
    it(@"can push", ^{
        
        [mainViewController performSegueWithIdentifier:@"showSecondary"
                                                sender:nil];
        
        expect(navigationController.topViewController).after(1).to.beInstanceOf(NSClassFromString(@"RDLSecondaryViewController"));
    });
    
    it(@"can present modally", ^{
        
        [mainViewController performSegueWithIdentifier:@"showSecondaryModal"
                                                sender:nil];
        
        expect(navigationController.presentedViewController).after(1).to.beInstanceOf(NSClassFromString(@"RDLSecondaryModalViewController"));
    });
    
    it(@"can embed", ^{
        
        [mainViewController performSegueWithIdentifier:@"showSecondary"
                                                sender:nil];
        
        expect(navigationController.topViewController).after(1).to.beInstanceOf(NSClassFromString(@"RDLSecondaryViewController"));
        
        UIViewController *firstChild = navigationController.topViewController.childViewControllers[0];
        
        expect(firstChild).to.beInstanceOf(NSClassFromString(@"RDLEmbeddedViewController"));
    });
});

SpecEnd

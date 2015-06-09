//
//  RDLViewController.m
//  Cutaway
//
//  Created by Fabio Rodella on 06/09/2015.
//  Copyright (c) 2014 Fabio Rodella. All rights reserved.
//

#import "RDLMainViewController.h"

#import "RDLSecondaryViewController.h"

@interface RDLMainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RDLMainViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSecondary"]) {
        
        RDLSecondaryViewController *vc = segue.destinationViewController;
        vc.textToShow = self.textField.text;
    } 
}

- (IBAction)unwindToMainViewController:(UIStoryboardSegue *)sender
{   
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"Dismissed modal"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];
}

@end

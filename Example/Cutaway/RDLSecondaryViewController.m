//
//  RDLSecondaryViewController.m
//  Cutaway
//
//  Created by Fabio Rodella on 6/9/15.
//  Copyright (c) 2015 Fabio Rodella. All rights reserved.
//

#import "RDLSecondaryViewController.h"

@interface RDLSecondaryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RDLSecondaryViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.textField.text = self.textToShow;
}

@end

//
//  MainViewController.m
//  OHSFootball
//
//  Created by Sam Gutentag on 8/27/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize userNameLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Main View";
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    // set label
    
    if (![PFUser currentUser]) {
        userNameLabel.text = [NSString stringWithFormat:@"Not Signed In"];
    } else {
        
        userNameLabel.text = [NSString stringWithFormat:@"Current User is:\n\n%@", [PFUser currentUser].username];
    }
    [userNameLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
    [userNameLabel setTextAlignment:NSTextAlignmentCenter];
    userNameLabel.textColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  LogInViewController.h
//  OHSFootball
//
//  Created by Sam Gutentag on 8/31/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AccountViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


- (IBAction)logOut:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *currentUserLabel;
@property (strong, nonatomic) IBOutlet UILabel *logOutButtonLabel;


@end

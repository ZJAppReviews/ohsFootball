//
//  LogInViewController.m
//  OHSFootball
//
//  Created by Sam Gutentag on 8/31/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "AccountViewController.h"
#import "SWRevealViewController.h"
#import "MainViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize currentUserLabel, logOutButtonLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.title = @"User Accounts";
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // is no user is logged in
    if (![PFUser currentUser]) {
        // Customize the Log In View Controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self];
        [logInViewController setFields: PFLogInFieldsLogInButton | PFLogInFieldsDismissButton | PFLogInFieldsSignUpButton | PFLogInFieldsUsernameAndPassword];
        
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
        
        
    } else {
        // set label
        currentUserLabel.text = [NSString stringWithFormat:@"Current User is:\n\n%@", [PFUser currentUser].username];
        [currentUserLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
        [currentUserLabel setTextAlignment:NSTextAlignmentCenter];
        currentUserLabel.textColor = [UIColor whiteColor];
        
        logOutButtonLabel.text = @"Log Out";
        [logOutButtonLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
        [logOutButtonLabel setTextAlignment:NSTextAlignmentCenter];
        logOutButtonLabel.textColor = [UIColor whiteColor];
        

    }
}

- (IBAction)logOut:(id)sender {
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Whoa now!"
                                 message:@"Are you sure you want to log out?"
                                 delegate:self
                                 cancelButtonTitle:@"Nevermind"
                                 otherButtonTitles:@"Log Out", nil];
    
    // Display Alert Message
    [messageAlert show];
}

// handle alerts
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];

    if([title isEqualToString:@"Log Out"])
	{
        [PFUser logOut];
        [self performSegueWithIdentifier:@"toMainView" sender:self];
	}
    
}

//------------------------------------------------------------------------------
//      Log In Delegation Methods
//------------------------------------------------------------------------------

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    // go to main menu
    [self performSegueWithIdentifier:@"toMainView" sender:self];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    MainViewController *mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self.navigationController pushViewController:mainView animated:YES];
}

//------------------------------------------------------------------------------
//      Sign Up Delegation Methods
//------------------------------------------------------------------------------

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:NO completion:nil];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}










- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

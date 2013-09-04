//
//  ScoreReportingViewController.m
//  OHSFootball
//
//  Created by Sam Gutentag on 9/3/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "ScoreReportingViewController.h"

@interface ScoreReportingViewController ()

@end

@implementation ScoreReportingViewController

@synthesize teamNameLabel, opponentNameLabel, teamMascotLabel, opponentMascotLabel;
@synthesize teamName, opponentName, teamScore, opponentScore, teamMascot, opponentMascot;

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
    
    
    // view title
    self.title = @"Report Score";
    
    teamMascotLabel.text = teamMascot;
    opponentMascotLabel.text = opponentMascot;
}



- (IBAction)goBackButton:(id)sender {
    
    NSLog(@"Go back button pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitScoreButton:(id)sender {
    
    NSLog(@"Submit Score Button Pressed");
    
    // submit score here somehow....
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

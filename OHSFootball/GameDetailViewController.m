//
//  GameDetailViewController.m
//  OHSFootball
//
//  Created by Sam Gutentag on 9/2/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "GameDetailViewController.h"

@interface GameDetailViewController ()

@end

@implementation GameDetailViewController

@synthesize teamMascotLabel, opponentMascotLabel;
@synthesize teamMascot, opponentMascot, teamScore, opponentScore;
@synthesize gradientImage;
@synthesize gradient, homeGameIndicatorImage;
@synthesize gameTimeLabel, gameDateLabel, gameLocationLabel;
@synthesize homeGameIndicator, gameTime, gameDate, gameLocation;
@synthesize teamScoreLabel, opponentScoreLabel;
@synthesize teamGradDarkR, teamGradDarkB, teamGradDarkG;
@synthesize teamGradLightR, teamGradLightB, teamGradLightG;
@synthesize opponentGradDarkR, opponentGradDarkB, opponentGradDarkG;
@synthesize opponentGradLightR, opponentGradLightB, opponentGradLightG;

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
    self.title = @"Game Details";
    
    //--------------------------------------------------------------------------
    // Team Mascot
    //--------------------------------------------------------------------------
    teamMascotLabel.text = teamMascot;
    [teamMascotLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
    teamMascotLabel.textColor = [UIColor colorWithRed:teamGradLightR green:teamGradLightG blue:teamGradLightB alpha:1.0];
    teamMascotLabel.textAlignment = NSTextAlignmentCenter;
    
    //--------------------------------------------------------------------------
    // Opponent Mascot
    //--------------------------------------------------------------------------
    opponentMascotLabel.text = opponentMascot;
    [opponentMascotLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
    opponentMascotLabel.textColor = [UIColor colorWithRed:opponentGradLightR green:opponentGradLightG blue:opponentGradLightB alpha:1.0];
    opponentMascotLabel.textAlignment = NSTextAlignmentCenter;
    
    //--------------------------------------------------------------------------
    // Game Date
    //--------------------------------------------------------------------------
    gameDateLabel.text = gameDate;
    [gameDateLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
    gameDateLabel.textColor = [UIColor whiteColor];
    gameDateLabel.textAlignment = NSTextAlignmentLeft;
    
    //--------------------------------------------------------------------------
    // Game Time
    //--------------------------------------------------------------------------
    gameTimeLabel.text = gameTime;
    [gameTimeLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
    gameTimeLabel.textColor = [UIColor whiteColor];
    gameTimeLabel.textAlignment = NSTextAlignmentLeft;
    
    //--------------------------------------------------------------------------
    // Game Address
    //--------------------------------------------------------------------------
    gameLocationLabel.text = gameLocation;
    [gameLocationLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
    gameLocationLabel.textColor = [UIColor whiteColor];
    gameLocationLabel.textAlignment = NSTextAlignmentLeft;
    
    //--------------------------------------------------------------------------
    // Game Address - TBA Address
    //--------------------------------------------------------------------------
    if ([[gameLocation substringToIndex:3] isEqualToString:@"TBA"]) {
        
        gameLocationLabel.text = @"This is awkward...\nWe don't have an address\nfor this game right now.";
    }
    
    //--------------------------------------------------------------------------
    // Home Game Indicator
    //--------------------------------------------------------------------------
    if ([homeGameIndicator isEqualToString:@"home_icon.png"])
    {
        homeGameIndicatorImage.image = [UIImage imageNamed:@"home_icon.png"];
    }
    else
    {
        homeGameIndicatorImage.image = [UIImage imageNamed:@"away_icon.png"];
    }
    
    //--------------------------------------------------------------------------
    // Team Score
    //--------------------------------------------------------------------------
    teamScoreLabel.text = teamScore;
    [teamScoreLabel setFont:[UIFont fontWithName:@"Roboto" size:30]];
    teamScoreLabel.textColor = [UIColor colorWithRed:teamGradLightR green:teamGradLightG blue:teamGradLightB alpha:1.0];
    teamScoreLabel.textAlignment = NSTextAlignmentCenter;
    
    //--------------------------------------------------------------------------
    // Opponent Score
    //--------------------------------------------------------------------------
    opponentScoreLabel.text = opponentScore;
    [opponentScoreLabel setFont:[UIFont fontWithName:@"Roboto" size:30]];
    opponentScoreLabel.textColor = [UIColor colorWithRed:opponentGradLightR green:opponentGradLightG blue:opponentGradLightB alpha:1.0];
    opponentScoreLabel.textAlignment = NSTextAlignmentCenter;
    
    //--------------------------------------------------------------------------
    // Winning Team indication
    //--------------------------------------------------------------------------
    if (teamScore.intValue > opponentScore.intValue) {
        [teamMascotLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:19]];
        [teamScoreLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:30]];
        
    }
    else if (teamScore.intValue < opponentScore.intValue){
        [opponentMascotLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:19]];
        [opponentScoreLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:30]];
    }
    
    //--------------------------------------------------------------------------
    // Background Gradient
    //--------------------------------------------------------------------------
    // image size, just needs to be 1px high
    CGSize size = CGSizeMake(320, 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    // set gradient 'anchor' points
    size_t gradientNumberOfLocations = 3;
    CGFloat gradientLocations[3] = { 0.0, 0.5, 1.0 };
    
    
    // Team Dark Color - Left
    CGFloat Lr = teamGradDarkR;
    CGFloat Lg = teamGradDarkG;
    CGFloat Lb = teamGradDarkB;
    CGFloat La = 1.0f;
    
    // Opponent Dark Color - Right
    CGFloat Rr = opponentGradDarkR;
    CGFloat Rg = opponentGradDarkG;
    CGFloat Rb = opponentGradDarkB;
    CGFloat Ra = 1.0f;
    
    CGFloat teamGradientComponents[12] = { Lr, Lg, Lb, La, 0.0, 0.0, 0.0, 1.0, Rr, Rg, Rb, Ra};
    CGGradientRef teamGradient = CGGradientCreateWithColorComponents (colorspace, teamGradientComponents, gradientLocations, gradientNumberOfLocations);
    CGContextDrawLinearGradient(context, teamGradient, CGPointMake(0, 0.5), CGPointMake(size.width, size.height), 0);
    
    // draw gradient to image, apply to image view in storyboard
    UIImage *Gradient = UIGraphicsGetImageFromCurrentImageContext();
    gradientImage.image = Gradient;
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ScheduleViewController.m
//  OHSFootball
//
//  Created by Sam Gutentag on 8/28/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleCell.h"
#import "SWRevealViewController.h"
#import "GameDetailViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

@synthesize teamData, scheduleData;
@synthesize scheduleType;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // support side bar navigation
    self.title = [NSString stringWithFormat:@"%@ Schedule", scheduleType];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    // Find out the path of team_info.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"team_info" ofType:@"plist"];
    self.teamData = [NSMutableArray arrayWithContentsOfFile:path];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ----------------------------------------------------------------------------------------------------
//      Parse
// ----------------------------------------------------------------------------------------------------

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        
        if ([self.restorationIdentifier isEqualToString:@"varsityScheduleTableView"]) {
            self.parseClassName = @"varsity_schedule";
        }
        
        else if ([self.restorationIdentifier isEqualToString:@"jvScheduleTableView"]) {
            self.parseClassName = @"jv_schedule";
        }
        else if ([self.restorationIdentifier isEqualToString:@"freshmenScheduleTableView"]) {
            self.parseClassName = @"freshmen_schedule";
        }
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"opponentName";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
    }
    return self;
}

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // enable caching for offline access
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    // sort games in correct order
    [query orderByAscending:@"sortingDate"];
    
    return query;
}


// ----------------------------------------------------------------------------------------------------
//      TableView
// ----------------------------------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"ScheduleCell";
    
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    // Configure the cell...
    // ----------------------------------------------------------------------------------------------------
    //      Team Name
    // ----------------------------------------------------------------------------------------------------
    cell.teamName.text = [self.teamData objectAtIndex:0][@"name"];
    [cell.teamName setFont:[UIFont fontWithName:@"Roboto" size:19]];
    cell.teamName.textColor = [UIColor whiteColor];
    cell.teamName.textAlignment = NSTextAlignmentLeft;
    
    // ----------------------------------------------------------------------------------------------------
    //      Opponent Team Name
    // ----------------------------------------------------------------------------------------------------
    cell.opponentTeamName.text = [object objectForKey:@"Opponent"];
    [cell.opponentTeamName setFont:[UIFont fontWithName:@"Roboto" size:19]];
    cell.opponentTeamName.textColor = [UIColor whiteColor];
    cell.opponentTeamName.textAlignment = NSTextAlignmentLeft;
    
    // ----------------------------------------------------------------------------------------------------
    //      Game Date & Time
    // ----------------------------------------------------------------------------------------------------
    
    cell.gameDateTime.text = [NSString stringWithFormat:@"%@ - %@", [object objectForKey:@"gameDate"], [object objectForKey:@"gameTime"]];
    [cell.gameDateTime setFont:[UIFont fontWithName:@"Roboto" size:14]];
    cell.gameDateTime.textColor = [UIColor whiteColor];
    cell.gameDateTime.textAlignment = NSTextAlignmentLeft;
    
    // ----------------------------------------------------------------------------------------------------
    //      Home or Away Indicator
    // ----------------------------------------------------------------------------------------------------
    
    NSString *homeStatus = [object objectForKey:@"Home"];
    
    if ([homeStatus boolValue])
    {
        cell.homeGameIndicator.image = [UIImage imageNamed:@"home_icon.png"];
    }
    else
    {
        cell.homeGameIndicator.image = [UIImage imageNamed:@"away_icon.png"];
    }
    
    // ----------------------------------------------------------------------------------------------------
    //      Team Gradient
    // ----------------------------------------------------------------------------------------------------
    
    // image size, just needs to be 1px high
    CGSize size = CGSizeMake(320, 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    // set gradient 'anchor' points
    size_t gradientNumberOfLocations = 4;
    CGFloat gradientLocations[4] = { 0.0, 0.7, 0.8, 1.0 };
    
    // Team Gradient
    // left color
    CGFloat Lr = [[self.teamData objectAtIndex:0][@"gradient_darkR"] floatValue]/255.0;
    CGFloat Lg = [[self.teamData objectAtIndex:0][@"gradient_darkG"] floatValue]/255.0;
    CGFloat Lb = [[self.teamData objectAtIndex:0][@"gradient_darkB"] floatValue]/255.0;
    CGFloat La = 1.0f;
    
    // right color
    CGFloat Rr = [[self.teamData objectAtIndex:0][@"gradient_lightR"] floatValue]/255.0;
    CGFloat Rg = [[self.teamData objectAtIndex:0][@"gradient_lightG"] floatValue]/255.0;
    CGFloat Rb = [[self.teamData objectAtIndex:0][@"gradient_lightB"] floatValue]/255.0;
    CGFloat Ra = 1.0f;
    
    
    //CGFloat teamGradientComponents[8] = { Lr, Lg, Lb, La, Rr, Rg, Rb, Ra};
    CGFloat teamGradientComponents[16] = { Lr, Lg, Lb, La, Rr, Rg, Rb, Ra, Rr, Rg, Rb, 0.5, 0.5, 0.5, 0.5, 0.5};
    CGGradientRef teamGradient = CGGradientCreateWithColorComponents (colorspace, teamGradientComponents, gradientLocations, gradientNumberOfLocations);
    CGContextDrawLinearGradient(context, teamGradient, CGPointMake(0, 0.5), CGPointMake(size.width, size.height), 0);
    
    // draw gradient to image, apply to image view in storyboard
    UIImage *team_gradient = UIGraphicsGetImageFromCurrentImageContext();
    cell.teamGradient.image = team_gradient;
    
    // Opponent Gradient
    // left color
    Lr = [[object objectForKey:@"opponent_darkR"] floatValue]/255.0;
    Lg = [[object objectForKey:@"opponent_darkG"] floatValue]/255.0;
    Lb = [[object objectForKey:@"opponent_darkB"] floatValue]/255.0;
    La = 1.0f;
    
    // right color
    Rr = [[object objectForKey:@"opponent_lightR"] floatValue]/255.0;
    Rg = [[object objectForKey:@"opponent_lightG"] floatValue]/255.0;
    Rb = [[object objectForKey:@"opponent_lightB"] floatValue]/255.0;
    Ra = 1.0f;
    
    //CGFloat opponentGradientComponents[8] = { Lr, Lg, Lb, La, Rr, Rg, Rb, Ra};
    CGFloat opponentGradientComponents[16] = { Lr, Lg, Lb, La, Rr, Rg, Rb, Ra, Rr, Rg, Rb, 0.5, 0.5, 0.5, 0.5, 0.5};
    CGGradientRef opponentGradient = CGGradientCreateWithColorComponents (colorspace, opponentGradientComponents, gradientLocations, gradientNumberOfLocations);
    CGContextDrawLinearGradient(context, opponentGradient, CGPointMake(0, 0.5), CGPointMake(size.width, size.height), 0);
    
    // draw gradient to image, apply to image view in storyboard
    UIImage *opponent_gradient = UIGraphicsGetImageFromCurrentImageContext();
    cell.opponentGradient.image = opponent_gradient;
    
    // ----------------------------------------------------------------------------------------------------
    //      Game Scores
    // ----------------------------------------------------------------------------------------------------
    cell.opponentScoreLabel.text = [object objectForKey:@"opponentScore"];
    [cell.opponentScoreLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
    cell.opponentScoreLabel.textColor = [UIColor whiteColor];
    cell.opponentScoreLabel.textAlignment = NSTextAlignmentRight;
    
    cell.teamScoreLabel.text = [object objectForKey:@"teamScore"];
    [cell.teamScoreLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
    cell.teamScoreLabel.textColor = [UIColor whiteColor];
    cell.teamScoreLabel.textAlignment = NSTextAlignmentRight;
    
    
    // ----------------------------------------------------------------------------------------------------
    //      Game Winner Icon
    // ----------------------------------------------------------------------------------------------------
    
    cell.teamWinIndicator.image = [UIImage imageNamed:@"blank_icon.png"];
    cell.opponentWinIndicator.image = [UIImage imageNamed:@"blank_icon.png"];
    
    NSString *teamScore = [object objectForKey:@"teamScore"];
    NSString *opponentScore = [object objectForKey:@"opponentScore"];
    
    if (teamScore.intValue > opponentScore.intValue) {
        cell.teamWinIndicator.image = [UIImage imageNamed:@"win_icon.png"];
        [cell.teamName setFont:[UIFont fontWithName:@"Roboto-Medium" size:19]];
        [cell.teamScoreLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:19]];
        
    }
    else if (teamScore.intValue < opponentScore.intValue){
        cell.opponentWinIndicator.image = [UIImage imageNamed:@"win_icon.png"];
        [cell.opponentTeamName setFont:[UIFont fontWithName:@"Roboto-Medium" size:19]];
        [cell.opponentScoreLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:19]];
    }
    
    // ----------------------------------------------------------------------------------------------------
    //      Turn Off Selection Highlighting for rows
    // ----------------------------------------------------------------------------------------------------
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // ----------------------------------------------------------------------------------------------------
    //      Show Table Row Separators
    // ----------------------------------------------------------------------------------------------------
    tableView.separatorColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor colorWithRed:119.0f/255.0f green:119.0f/255.0f blue:119.0f/255.0f alpha:1.0f];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

// because we are using a custom cell, need to specify height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // height of cell
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    // make Blue highlight fade
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// ----------------------------------------------------------------------------------------------------
//      Segue to Game Detail View
// ----------------------------------------------------------------------------------------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GameDetailSegue"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        
        GameDetailViewController *destViewController = segue.destinationViewController;
        
        // ----------------------------------------------------------------------------------------------------
        //      Team Names
        // ----------------------------------------------------------------------------------------------------
        destViewController.teamMascot = [self.teamData objectAtIndex:0][@"mascot"];
        destViewController.opponentMascot = [object objectForKey:@"Mascot"];
        
        // ----------------------------------------------------------------------------------------------------
        //      Game Time and Date
        // ----------------------------------------------------------------------------------------------------
        destViewController.gameTime = [object objectForKey:@"gameTime"];
        destViewController.gameDate = [object objectForKey:@"gameDate"];
        
        // ----------------------------------------------------------------------------------------------------
        //      Game Location
        // ----------------------------------------------------------------------------------------------------
        NSString *location = [NSString stringWithFormat:@"%@\n%@\n%@, %@ %@",[object objectForKey:@"gameLocationName"], [object objectForKey:@"gameAddressStreet"], [object objectForKey:@"gameAddressCity"], [object objectForKey:@"gameAddressState"],[object objectForKey:@"gameAddressZip"] ];
        
        destViewController.gameLocation = location;
        
        // ----------------------------------------------------------------------------------------------------
        //      Team Gradients
        // ----------------------------------------------------------------------------------------------------
        
        // Team Dark Color
        CGFloat Tr = [[self.teamData objectAtIndex:0][@"gradient_darkR"] floatValue]/255.0;
        CGFloat Tg = [[self.teamData objectAtIndex:0][@"gradient_darkG"] floatValue]/255.0;
        CGFloat Tb = [[self.teamData objectAtIndex:0][@"gradient_darkB"] floatValue]/255.0;
        destViewController.teamGradDarkR = Tr;
        destViewController.teamGradDarkG = Tg;
        destViewController.teamGradDarkB = Tb;
        // Team Light Color
        Tr = [[self.teamData objectAtIndex:0][@"gradient_lightR"] floatValue]/255.0;
        Tg = [[self.teamData objectAtIndex:0][@"gradient_lightG"] floatValue]/255.0;
        Tb = [[self.teamData objectAtIndex:0][@"gradient_lightB"] floatValue]/255.0;
        destViewController.teamGradLightR = Tr;
        destViewController.teamGradLightG = Tg;
        destViewController.teamGradLightB = Tb;
        
        
        // Opponent Dark Color
        CGFloat Or = [[object objectForKey:@"opponent_darkR"] floatValue]/255.0;
        CGFloat Og = [[object objectForKey:@"opponent_darkG"] floatValue]/255.0;
        CGFloat Ob = [[object objectForKey:@"opponent_darkB"] floatValue]/255.0;
        destViewController.opponentGradDarkR = Or;
        destViewController.opponentGradDarkG = Og;
        destViewController.opponentGradDarkB = Ob;

        // Opponent Light Color
        Or = [[object objectForKey:@"opponent_lightR"] floatValue]/255.0;
        Og = [[object objectForKey:@"opponent_lightG"] floatValue]/255.0;
        Ob = [[object objectForKey:@"opponent_lightB"] floatValue]/255.0;
        destViewController.opponentGradLightR = Or;
        destViewController.opponentGradLightG = Og;
        destViewController.opponentGradLightB = Ob;
        
        // ----------------------------------------------------------------------------------------------------
        //      Score
        // ----------------------------------------------------------------------------------------------------
        destViewController.teamScore = [object objectForKey:@"teamScore"];
        destViewController.opponentScore = [object objectForKey:@"opponentScore"];
        
        // ----------------------------------------------------------------------------------------------------
        //      Home or Away Indicator
        // ----------------------------------------------------------------------------------------------------
        NSString *homeStatus = [object objectForKey:@"Home"];
        if ([homeStatus boolValue])
        {
            destViewController.homeGameIndicator = @"home_icon";
        }
        else
        {
            destViewController.homeGameIndicator = @"away_icon.png";
        }
        
        // ----------------------------------------------------------------------------------------------------
        //      Location for Mapping
        // ----------------------------------------------------------------------------------------------------
        /*
         destViewController.gameAddressForMap = [object objectForKey:@"gameAddress_forMap"];
         */
        
    }
}

@end

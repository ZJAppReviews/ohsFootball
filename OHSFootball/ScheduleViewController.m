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
    //      Game Time
    // ----------------------------------------------------------------------------------------------------
    cell.gameTime.text = [object objectForKey:@"gameTime"];
    [cell.gameTime setFont:[UIFont fontWithName:@"Roboto" size:16]];
    cell.gameTime.textColor = [UIColor blackColor];
    cell.gameTime.textAlignment = NSTextAlignmentCenter;
    
    // ----------------------------------------------------------------------------------------------------
    //      Game Date
    // ----------------------------------------------------------------------------------------------------
    cell.gameDate.text = [object objectForKey:@"gameDate"];
    [cell.gameDate setFont:[UIFont fontWithName:@"Roboto" size:16]];
    cell.gameDate.textColor = [UIColor blackColor];
    cell.gameDate.textAlignment = NSTextAlignmentCenter;
    
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
    size_t gradientNumberOfLocations = 2;
    CGFloat gradientLocations[2] = { 0.0, 1.0 };
    
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
    
    
    CGFloat teamGradientComponents[8] = { Lr, Lg, Lb, La, Rr, Rg, Rb, Ra};
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
    
    CGFloat opponentGradientComponents[8] = { Lr, Lg, Lb, La, Rr, Rg, Rb, Ra};
    CGGradientRef opponentGradient = CGGradientCreateWithColorComponents (colorspace, opponentGradientComponents, gradientLocations, gradientNumberOfLocations);
    CGContextDrawLinearGradient(context, opponentGradient, CGPointMake(0, 0.5), CGPointMake(size.width, size.height), 0);
    
    // draw gradient to image, apply to image view in storyboard
    UIImage *opponent_gradient = UIGraphicsGetImageFromCurrentImageContext();
    cell.opponentGradient.image = opponent_gradient;
    
    // ----------------------------------------------------------------------------------------------------
    //      Game Scores
    // ----------------------------------------------------------------------------------------------------
    // set scores to zero as defualt
    NSString *opponentScore01 = @"0";
    NSString *opponentScore10 = @"0";
    
    NSString *teamScore01 = @"0";
    NSString *teamScore10 = @"0";
    
    // Adjust Away Score
    if ([[object objectForKey:@"opponentScore"]intValue] > 0) {
        
        // if greater than 9
        if ([[object objectForKey:@"opponentScore"]intValue] > 9) {
            opponentScore01 = [[object objectForKey:@"opponentScore"] substringFromIndex:1];
            opponentScore10 = [[object objectForKey:@"opponentScore"] substringToIndex:1];
        }
        else {
            opponentScore01 = [object objectForKey:@"opponentScore"];
        }
    }
    
    // Adjust Home Score
    if ([[object objectForKey:@"teamScore"]intValue] > 9) {
        
        // if greater than 9
        if ([[object objectForKey:@"teamScore"]intValue] > 9) {
            teamScore01 = [[object objectForKey:@"teamScore"] substringFromIndex:1];
            teamScore10 = [[object objectForKey:@"teamScore"] substringToIndex:1];
        }
        else {
            teamScore01 = [object objectForKey:@"teamScore"];
        }
    }
    
    cell.teamScore_01.image = [UIImage imageNamed:[NSString stringWithFormat:@"scoreNumbers_%@.png", teamScore01]];
    cell.teamScore_10.image = [UIImage imageNamed:[NSString stringWithFormat:@"scoreNumbers_%@.png", teamScore10]];
    cell.opponentScore_01.image = [UIImage imageNamed:[NSString stringWithFormat:@"scoreNumbers_%@.png", opponentScore01]];
    cell.opponentScore_10.image = [UIImage imageNamed:[NSString stringWithFormat:@"scoreNumbers_%@.png", opponentScore10]];
    
    // ----------------------------------------------------------------------------------------------------
    //      Turn Off Selection Highlighting for rows
    // ----------------------------------------------------------------------------------------------------
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // ----------------------------------------------------------------------------------------------------
    //      Show Table Row Separators
    // ----------------------------------------------------------------------------------------------------
    tableView.separatorColor = [UIColor grayColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    // make Blue highlight fade
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

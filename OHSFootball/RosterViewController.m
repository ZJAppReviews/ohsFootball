//
//  VarsityRosterViewController.m
//  OHSFootball
//
//  Created by Sam Gutentag on 8/27/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "RosterViewController.h"
#import "RosterCell.h"
#import "SWRevealViewController.h"

@interface RosterViewController ()

@end

@implementation RosterViewController

@synthesize playerData;
@synthesize rosterType;

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
    self.title = [NSString stringWithFormat:@"%@ Roster", rosterType];
    
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
        
        if ([self.restorationIdentifier isEqualToString:@"varsityRosterTableView"]) {
            self.parseClassName = @"varsity_roster";
        }
        
        else if ([self.restorationIdentifier isEqualToString:@"freshmenRosterTableView"]) {
            self.parseClassName = @"freshmen_roster";
        }
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"Name";
        
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
    [query orderByAscending:@"Number"];
    
    return query;
}

// ----------------------------------------------------------------------------------------------------
//      TableView
// ----------------------------------------------------------------------------------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"RosterCell";
    
    RosterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[RosterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    // Configure the cell...
    
    // ----------------------------------------------------------------------------------------------------
    //      Player Name
    // ----------------------------------------------------------------------------------------------------
    cell.nameLabel.text = [object objectForKey:@"Name"];
    [cell.nameLabel setFont:[UIFont fontWithName:@"Roboto" size:19]];
    cell.nameLabel.textColor = [UIColor whiteColor];
    cell.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    // ----------------------------------------------------------------------------------------------------
    //      Player Number
    // ----------------------------------------------------------------------------------------------------
    cell.numberLabel.text = [object objectForKey:@"Number"];
    [cell.numberLabel setFont:[UIFont fontWithName:@"Roboto" size:19]];
    cell.numberLabel.textColor = [UIColor blackColor];
    cell.numberLabel.textAlignment = NSTextAlignmentCenter;
    
    // ----------------------------------------------------------------------------------------------------
    //      Player Position
    // ----------------------------------------------------------------------------------------------------
    cell.positionLabel.text = [object objectForKey:@"Position"];
    [cell.positionLabel setFont:[UIFont fontWithName:@"Roboto" size:14]];
    cell.positionLabel.textColor = [UIColor blackColor];
    cell.positionLabel.textAlignment = NSTextAlignmentCenter;
    
    // ----------------------------------------------------------------------------------------------------
    //      Player Grade
    // ----------------------------------------------------------------------------------------------------
    
    NSString *grade = [object objectForKey:@"Grade"];
    if ([grade isEqualToString:@"9"]) {
        grade = @"Freshmen";
    }else if ([grade isEqualToString:@"10"])
    {
        grade = @"Sophomore";
    }else if ([grade isEqualToString:@"11"])
    {
        grade = @"Junior";
    }else if ([grade isEqualToString:@"12"])
    {
        grade = @"Senior";
    }
    
    cell.gradeLabel.text = grade;
    [cell.gradeLabel setFont:[UIFont fontWithName:@"Roboto" size:14]];
    cell.gradeLabel.textColor = [UIColor blackColor];
    cell.gradeLabel.textAlignment = NSTextAlignmentCenter;
    
    // ----------------------------------------------------------------------------------------------------
    //      Player Height
    // ----------------------------------------------------------------------------------------------------
    
    // convert inches to f'in"
    NSString *height = [object objectForKey:@"Height"];
    int numHeight = [height intValue];
    int feet = numHeight / 12;
    int inches = numHeight % 12;
    
    cell.heightLabel.text = [NSString stringWithFormat:@"%d'%d\"" , feet, inches];
    [cell.heightLabel setFont:[UIFont fontWithName:@"Roboto" size:14]];
    cell.heightLabel.textColor = [UIColor blackColor];
    cell.heightLabel.textAlignment = NSTextAlignmentCenter;
    
    // ----------------------------------------------------------------------------------------------------
    //      Player Weight
    // ----------------------------------------------------------------------------------------------------
    cell.weightLabel.text = [NSString stringWithFormat:@"%@ lbs", [object objectForKey:@"Weight"]];
    [cell.weightLabel setFont:[UIFont fontWithName:@"Roboto" size:14]];
    cell.weightLabel.textColor = [UIColor blackColor];
    cell.weightLabel.textAlignment = NSTextAlignmentCenter;
    
    // ----------------------------------------------------------------------------------------------------
    //      Jersey Number
    // ----------------------------------------------------------------------------------------------------
    cell.numberLabel.text = [object objectForKey:@"Number"];
    [cell.numberLabel setFont:[UIFont fontWithName:@"JerseyLetters" size:24]];
    cell.numberLabel.textColor = [UIColor whiteColor];
    cell.numberLabel.textAlignment = NSTextAlignmentCenter;
    
    
    // ----------------------------------------------------------------------------------------------------
    //      Accolade Labels
    // ----------------------------------------------------------------------------------------------------
    NSString *capStatus = [object objectForKey:@"Captain"];
    NSString *letterStatus = [object objectForKey:@"LetterWinner"];
    
    
    if ([capStatus boolValue] && [letterStatus boolValue]) {
        cell.accoladeLabel.text = @"(C)Letter Winner";
    } else if ([letterStatus boolValue] && ![capStatus boolValue]) {
        cell.accoladeLabel.text = @"Letter Winner";
    } else {
        cell.accoladeLabel.text = @"";
    }
    
    
    [cell.accoladeLabel setFont:[UIFont fontWithName:@"Roboto" size:14]];
    cell.accoladeLabel.textColor = [UIColor whiteColor];
    cell.accoladeLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    // ----------------------------------------------------------------------------------------------------
    //      Thumbnail Image
    // ----------------------------------------------------------------------------------------------------
    if ([self.rosterType isEqualToString:@"Varsity"]) {
        cell.thumbnailImage.image = [UIImage imageNamed:@"default_picture_right.png"];
    }
    
    else if ([self.rosterType isEqualToString:@"Freshmen"]) {
        cell.thumbnailImage.image = [UIImage imageNamed:@"default_picture_left.png"];
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
    
    // left color
    CGFloat Lr = [[self.teamData objectAtIndex:0][@"gradient_lightR"] floatValue]/255.0;
    CGFloat Lg = [[self.teamData objectAtIndex:0][@"gradient_lightG"] floatValue]/255.0;
    CGFloat Lb = [[self.teamData objectAtIndex:0][@"gradient_lightB"] floatValue]/255.0;
    CGFloat La = 1.0f;
    
    // right color
    CGFloat Rr = [[self.teamData objectAtIndex:0][@"gradient_darkR"] floatValue]/255.0;
    CGFloat Rg = [[self.teamData objectAtIndex:0][@"gradient_darkG"] floatValue]/255.0;
    CGFloat Rb = [[self.teamData objectAtIndex:0][@"gradient_darkB"] floatValue]/255.0;
    CGFloat Ra = 1.0f;
    
    
    CGFloat gradientComponents[8] = { Lr, Lg, Lb, La, Rr, Rg, Rb, Ra};
    CGGradientRef gradient = CGGradientCreateWithColorComponents (colorspace, gradientComponents, gradientLocations, gradientNumberOfLocations);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0.5), CGPointMake(size.width, size.height), 0);
    
    // draw gradient to image, apply to image view in storyboard
    UIImage *gradient01 = UIGraphicsGetImageFromCurrentImageContext();
    cell.teamGradient.image = gradient01;
    
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
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    // make Blue highlight fade
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

//
//  SidebarViewController.m
//  OHSFootball
//
//  Created by Sam Gutentag on 8/28/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "SideBarCell.h"
#import "RosterViewController.h"
#import "ScheduleViewController.h"


@interface SidebarViewController ()

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *menuItemPrettyNames;
@property (nonatomic, strong) NSArray *menuItemThumbnailImageName;
@property (nonatomic, strong) NSArray *menuItemTeamLabel;

@end

@implementation SidebarViewController

@synthesize teamData;

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
    
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor whiteColor];

    _menuItems = @[@"title", @"varsity_Roster", @"freshmen_Roster",
                   @"varsity_schedule", @"jv_schedule", @"freshmen_schedule",
                   @"picWeek", @"feedback", @"developerInfo", @"logIn"];

    _menuItemPrettyNames = @[@"title", @"Varsity Roster", @"Freshmen Roster",
                             @"Varsity Schedule", @"JV Schedule", @"Freshmen Schedule",
                             @"Picture of the Week", @"Feedback", @"Developer Info", @"Account"];
    
    _menuItemThumbnailImageName = @[@"title", @"roster", @"roster",
                                    @"calendar", @"calendar", @"calendar",
                                    @"polaroid", @"bullhorn", @"gear", @"user"];
    
    _menuItemTeamLabel = @[@"", @"V", @"F",
                                    @"V", @"JV", @"F",
                                    @"", @"", @"", @""];
    
    // Find out the path of team_info.plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"team_info" ofType:@"plist"];
    self.teamData = [NSMutableArray arrayWithContentsOfFile:path];
    
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    /*
     // Set the photo if it navigates to the PhotoView
     if ([segue.identifier isEqualToString:@"showPhoto"]) {
     PhotoViewController *photoController = (PhotoViewController*)segue.destinationViewController;
     NSString *photoFilename = [NSString stringWithFormat:@"%@_photo.jpg", [_menuItems objectAtIndex:indexPath.row]];
     photoController.photoFilename = photoFilename;
     }
     */
    
    if ([segue.identifier isEqualToString:@"showVarsityRoster"]) {
        RosterViewController *rosterController = (RosterViewController*)segue.destinationViewController;
        rosterController.rosterType = @"Varsity";
        
    }
    
    if ([segue.identifier isEqualToString:@"showFreshmenRoster"]) {
        RosterViewController *rosterController = (RosterViewController*)segue.destinationViewController;
        rosterController.rosterType = @"Freshmen";
        
    }
    
    if ([segue.identifier isEqualToString:@"showVarsitySchedule"]) {
        ScheduleViewController *scheduleController = (ScheduleViewController*)segue.destinationViewController;
        scheduleController.scheduleType = @"Varsity";
        
    }
    if ([segue.identifier isEqualToString:@"showJVSchedule"]) {
        ScheduleViewController *scheduleController = (ScheduleViewController*)segue.destinationViewController;
        scheduleController.scheduleType = @"Junior Varsity";
        
    }
    if ([segue.identifier isEqualToString:@"showFreshmenSchedule"]) {
        ScheduleViewController *scheduleController = (ScheduleViewController*)segue.destinationViewController;
        scheduleController.scheduleType = @"Freshmen";
        
    }
    
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    SideBarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // ----------------------------------------------------------------------------------------------------
    //      Label
    // ----------------------------------------------------------------------------------------------------
    cell.rowLabel.text = [self.menuItemPrettyNames objectAtIndex:indexPath.row];
    [cell.rowLabel setFont:[UIFont fontWithName:@"Roboto" size:16]];
    cell.rowLabel.textColor = [UIColor whiteColor];
    
    // ----------------------------------------------------------------------------------------------------
    //      Team Label
    // ----------------------------------------------------------------------------------------------------
    cell.teamLabel.text = [self.menuItemTeamLabel objectAtIndex:indexPath.row];
    [cell.teamLabel setFont:[UIFont fontWithName:@"JerseyLetters" size:20]];
    cell.teamLabel.textColor = [UIColor whiteColor];
    cell.teamLabel.textAlignment = NSTextAlignmentCenter;
    
    // ----------------------------------------------------------------------------------------------------
    //      Thumbnail Image
    // ----------------------------------------------------------------------------------------------------
    cell.rowThumbnail.image = [UIImage imageNamed:
                               [NSString stringWithFormat:@"%@_icon.png",
                                [self.menuItemThumbnailImageName objectAtIndex:indexPath.row]]];
    
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
    CGFloat Lr = [[self.teamData objectAtIndex:0][@"gradient_darkR"] floatValue]/255.0;
    CGFloat Lg = [[self.teamData objectAtIndex:0][@"gradient_darkG"] floatValue]/255.0;
    CGFloat Lb = [[self.teamData objectAtIndex:0][@"gradient_darkB"] floatValue]/255.0;
    CGFloat La = 1.0f;
    
    // right color
    CGFloat Rr = [[self.teamData objectAtIndex:0][@"gradient_lightR"] floatValue]/255.0;
    CGFloat Rg = [[self.teamData objectAtIndex:0][@"gradient_lightG"] floatValue]/255.0;
    CGFloat Rb = [[self.teamData objectAtIndex:0][@"gradient_lightB"] floatValue]/255.0;
    CGFloat Ra = 1.0f;
    
    
    CGFloat gradientComponents[8] = { Lr, Lg, Lb, La, Rr, Rg, Rb, Ra};
    CGGradientRef gradient = CGGradientCreateWithColorComponents (colorspace, gradientComponents, gradientLocations, gradientNumberOfLocations);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0.5), CGPointMake(size.width, size.height), 0);
    
    // draw gradient to image, apply to image view in storyboard
    UIImage *gradient01 = UIGraphicsGetImageFromCurrentImageContext();
    cell.rowGradient.image = gradient01;
    
    tableView.separatorColor = [UIColor clearColor];
    

    
    return cell;
}

// because we are using a custom cell, need to specify height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // height of cell
    return 50;
}

@end

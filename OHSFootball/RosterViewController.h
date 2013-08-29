//
//  VarsityRosterViewController.h
//  OHSFootball
//
//  Created by Sam Gutentag on 8/27/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface RosterViewController : PFQueryTableViewController

@property (nonatomic, strong) NSMutableArray *playerData;
@property (nonatomic, strong) NSMutableArray *teamData;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (weak, nonatomic) NSString *rosterType;

@end

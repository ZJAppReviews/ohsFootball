//
//  ScheduleCell.m
//  OHSFootball
//
//  Created by Sam Gutentag on 8/28/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell

@synthesize teamName, opponentTeamName;
@synthesize homeGameIndicator, teamWinIndicator, opponentWinIndicator;
@synthesize teamScore, opponentScore;
@synthesize teamScoreLabel, opponentScoreLabel;
@synthesize teamGradient, opponentGradient;
@synthesize gameDateTime;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

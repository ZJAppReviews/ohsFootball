//
//  ScheduleCell.m
//  OHSFootball
//
//  Created by Sam Gutentag on 8/28/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell

@synthesize teamName, opponentTeamName, gameDate, gameTime;
@synthesize homeGameIndicator, teamGradient, opponentGradient;
@synthesize teamScore, opponentScore;
@synthesize teamScore_01, teamScore_10, opponentScore_01, opponentScore_10;

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

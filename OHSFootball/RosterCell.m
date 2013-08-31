//
//  VarsityRosterCell.m
//  OHSFootball
//
//  Created by Sam Gutentag on 8/27/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "RosterCell.h"

@implementation RosterCell

@synthesize nameLabel, numberLabel, gradeLabel, positionLabel, heightLabel, weightLabel, accoladeLabel;
@synthesize teamGradient, thumbnailImage;

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

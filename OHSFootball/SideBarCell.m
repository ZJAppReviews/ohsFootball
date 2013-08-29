//
//  SideBarCell.m
//  OHSFootball
//
//  Created by Sam Gutentag on 8/28/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import "SideBarCell.h"

@implementation SideBarCell

@synthesize rowLabel;
@synthesize rowGradient, rowThumbnail;

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

//
//  VarsityRosterCell.h
//  OHSFootball
//
//  Created by Sam Gutentag on 8/27/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RosterCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *numberLabel;

@property (nonatomic, strong) IBOutlet UILabel *gradeLabel;
@property (nonatomic, strong) IBOutlet UILabel *positionLabel;

@property (nonatomic, strong) IBOutlet UILabel *captainLabel;
@property (nonatomic, strong) IBOutlet UILabel *letterWinnerLabel;

@property (nonatomic, strong) IBOutlet UILabel *heightLabel;
@property (nonatomic, strong) IBOutlet UILabel *weightLabel;

@property (nonatomic, strong) IBOutlet UIImageView *teamGradient;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImage;


@end

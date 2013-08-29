//
//  ScheduleCell.h
//  OHSFootball
//
//  Created by Sam Gutentag on 8/28/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *teamName;
@property (nonatomic, strong) IBOutlet UILabel *opponentTeamName;
@property (nonatomic, strong) IBOutlet UIImageView *homeGameIndicator;

@property (nonatomic, copy) NSString *teamScore;
@property (nonatomic, copy) NSString *opponentScore;

@property (nonatomic, strong) IBOutlet UIImageView *teamScore_10;
@property (nonatomic, strong) IBOutlet UIImageView *teamScore_01;
@property (nonatomic, strong) IBOutlet UIImageView *opponentScore_10;
@property (nonatomic, strong) IBOutlet UIImageView *opponentScore_01;

@property (nonatomic, strong) IBOutlet UIImageView *teamGradient;
@property (nonatomic, strong) IBOutlet UIImageView *opponentGradient;

@property (nonatomic, strong) IBOutlet UILabel *gameTime;
@property (nonatomic, strong) IBOutlet UILabel *gameDate;

@end

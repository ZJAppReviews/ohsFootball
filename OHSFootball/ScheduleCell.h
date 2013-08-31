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

@property (nonatomic, strong) IBOutlet UIImageView *teamWinIndicator;
@property (nonatomic, strong) IBOutlet UIImageView *opponentWinIndicator;

@property (nonatomic, copy) NSString *teamScore;
@property (nonatomic, copy) NSString *opponentScore;

@property (nonatomic, strong) IBOutlet UILabel *teamScoreLabel;
@property (nonatomic, strong) IBOutlet UILabel *opponentScoreLabel;

@property (nonatomic, strong) IBOutlet UIImageView *teamGradient;
@property (nonatomic, strong) IBOutlet UIImageView *opponentGradient;

@property (nonatomic, strong) IBOutlet UILabel *gameDateTime;

@end

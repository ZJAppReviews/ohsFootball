//
//  GameDetailViewController.h
//  OHSFootball
//
//  Created by Sam Gutentag on 9/2/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GameDetailViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *teamMascotLabel;
@property (nonatomic, strong) NSString *teamMascot;

@property (nonatomic, strong) IBOutlet UILabel *opponentMascotLabel;
@property (nonatomic, strong) NSString *opponentMascot;

@property (nonatomic, strong) IBOutlet UILabel *teamScoreLabel;
@property (nonatomic, strong) NSString *teamScore;

@property (nonatomic, strong) IBOutlet UILabel *opponentScoreLabel;
@property (nonatomic, strong) NSString *opponentScore;

@property (nonatomic, strong) IBOutlet UIImageView *gradientImage;
@property (nonatomic, strong) NSString *gradient;

@property (nonatomic, strong) IBOutlet UIImageView *homeGameIndicatorImage;
@property (nonatomic, strong) NSString *homeGameIndicator;

@property (nonatomic, strong) IBOutlet UILabel *gameTimeLabel;
@property (nonatomic, strong)   NSString *gameTime;

@property (nonatomic, strong) IBOutlet UILabel *gameDateLabel;
@property (nonatomic, strong)   NSString *gameDate;

@property (nonatomic, strong) IBOutlet UILabel *gameLocationLabel;
@property (nonatomic, strong)   NSString *gameLocation;

@property (nonatomic) CGFloat teamGradDarkR;
@property (nonatomic) CGFloat teamGradDarkG;
@property (nonatomic) CGFloat teamGradDarkB;
@property (nonatomic) CGFloat teamGradLightR;
@property (nonatomic) CGFloat teamGradLightG;
@property (nonatomic) CGFloat teamGradLightB;

@property (nonatomic) CGFloat opponentGradDarkR;
@property (nonatomic) CGFloat opponentGradDarkG;
@property (nonatomic) CGFloat opponentGradDarkB;
@property (nonatomic) CGFloat opponentGradLightR;
@property (nonatomic) CGFloat opponentGradLightG;
@property (nonatomic) CGFloat opponentGradLightB;


@end

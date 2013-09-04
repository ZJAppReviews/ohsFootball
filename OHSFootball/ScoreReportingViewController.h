//
//  ScoreReportingViewController.h
//  OHSFootball
//
//  Created by Sam Gutentag on 9/3/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreReportingViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *teamNameLabel;
@property (nonatomic, strong)   NSString *teamName;

@property (nonatomic, strong) IBOutlet UILabel *opponentNameLabel;
@property (nonatomic, strong)   NSString *opponentName;


@property (nonatomic, strong) IBOutlet UILabel *teamMascotLabel;
@property (nonatomic, strong)   NSString *teamMascot;

@property (nonatomic, strong) IBOutlet UILabel *opponentMascotLabel;
@property (nonatomic, strong)   NSString *opponentMascot;

@property (nonatomic, strong) IBOutlet UIImageView *homeBackingImage;
@property (nonatomic, strong)   NSString *homeBacking;
@property (nonatomic, strong) IBOutlet UIImageView *awayBackingImage;
@property (nonatomic, strong)   NSString *awayBacking;

@property (nonatomic, strong) NSString *teamScore;
@property (nonatomic, strong) NSString *opponentScore;


- (IBAction)goBackButton:(id)sender;
- (IBAction)submitScoreButton:(id)sender;

@end

//
//  SideBarCell.h
//  OHSFootball
//
//  Created by Sam Gutentag on 8/28/13.
//  Copyright (c) 2013 Sam Gutentag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideBarCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *rowLabel;

@property (nonatomic, strong) IBOutlet UIImageView *rowThumbnail;
@property (nonatomic, strong) IBOutlet UIImageView *rowGradient;

@end

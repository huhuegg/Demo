//
//  ActivityAllTableViewCell.h
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"

@interface ActivityAllTableViewCell : UITableViewCell<MZTimerLabelDelegate>
@property (nonatomic,strong) UIImageView *bg_image;
@property (nonatomic,strong) MZTimerLabel *timeCountDown;
@property (nonatomic,strong) UILabel *mainLabel;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) UIImageView *hot_image;

@end

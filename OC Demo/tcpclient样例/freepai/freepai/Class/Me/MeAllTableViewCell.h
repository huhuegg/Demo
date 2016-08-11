//
//  MeAllTableViewCell.h
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAImageView.h"

@interface MeAllTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (nonatomic,strong) PAImageView *headImage;
@property (nonatomic,strong) UIImageView *LogoImage;
@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UILabel *bottomLabel;
@property (nonatomic,strong) UILabel *centerLabel;
@property (nonatomic,strong) UIView *meScrollView;
@property (nonatomic,strong) UIButton *addButton;
@end

//
//  ExchangePageTableViewCell.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangePageTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *bg_image;
@property (nonatomic,strong) UIImageView *tag_image;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailsLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *talkLabel;
@end

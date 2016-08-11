//
//  MyAddressTableViewCell.h
//  freepai
//
//  Created by jiangchao on 14-6-27.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAddressTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *logoImage;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *telephone;
@property (nonatomic,strong) UILabel *address;
-(void)animationLogoImg;
@end

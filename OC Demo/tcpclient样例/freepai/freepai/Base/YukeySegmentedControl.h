//
//  YukeySegmentedControl.h
//  TestInterface
//
//  Created by jiangchao on 14-6-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YukeySegmentedControlDelegate <NSObject>

@required
-(void)selectedButton:(UIButton*)btn;

@end

@interface YukeySegmentedControl : UIView
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *centerButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) id<YukeySegmentedControlDelegate>delegate;


- (id)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle centerTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle;
@end

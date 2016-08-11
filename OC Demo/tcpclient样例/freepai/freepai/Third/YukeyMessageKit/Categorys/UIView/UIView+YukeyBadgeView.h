//
//  UIView+YukeyBadgeView.h
//  freepai
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LKBadgeView.h"

@interface YukeyCircleView : UIView

@end

@interface UIView (YukeyBadgeView)

@property (nonatomic, assign) CGRect badgeViewFrame;
@property (nonatomic, strong, readonly) LKBadgeView *badgeView;

- (YukeyCircleView *)setupCircleBadge;

@end

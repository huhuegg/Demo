//
//  MeItemsControl.h
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeItemsControl : UIControl
@property (nonatomic,strong) NSString *mainTitle;
- (id)initWithFrame:(CGRect)frame image:(UIImage *)image titile:(NSString *)title;
@end

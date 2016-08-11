//
//  InstalledGameControl.h
//  freepai
//
//  Created by jiangchao on 14-6-16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstalledGameControl : UIControl
@property (nonatomic,strong) NSString *url;
- (id)initWithFrame:(CGRect)frame image:(UIImage *)image titile:(NSString *)title URL:(NSString *)urlString;
@end

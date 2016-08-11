//
//  MeItemsScrollView.h
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeItemsScrollViewDelegate <NSObject>

-(void)touchTheItemWithTitle:(NSString *)title;

@end

@interface MeItemsScrollView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong) id<MeItemsScrollViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame itemsArray:(NSArray *)itemsArray;
@end

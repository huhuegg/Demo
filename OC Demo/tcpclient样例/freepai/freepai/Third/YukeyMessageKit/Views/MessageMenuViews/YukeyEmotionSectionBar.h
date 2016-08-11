//
//  YukeyEmotionSectionBar.h
//  TestMessageKit
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YukeyEmotionManager.h"

@protocol YukeyEmotionSectionBarDelegate <NSObject>
/**
 *  点击某一类gif表情的回调方法
 *
 *  @param emotionManager 被点击的管理表情Model对象
 *  @param section        被点击的位置
 */
- (void)didSelecteEmotionManager:(YukeyEmotionManager *)emotionManager atSection:(NSInteger)section;

@end

@interface YukeyEmotionSectionBar : UIView

@property (nonatomic, weak) id <YukeyEmotionSectionBarDelegate> delegate;

/**
 *  数据源
 */
@property (nonatomic, strong) NSArray *emotionManagers;

- (instancetype)initWithFrame:(CGRect)frame showEmotionStoreButton:(BOOL)isShowEmotionStoreButtoned;


/**
 *  根据数据源刷新UI布局和数据
 */
- (void)reloadData;
@end

//
//  YukeyEmotionCollectionViewCell.h
//  TestMessageKit
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YukeyEmotion.h"

#define kXHEmotionCollectionViewCellIdentifier @"YukeyEmotionCollectionViewCellIdentifier"

@interface YukeyEmotionCollectionViewCell : UICollectionViewCell

/**
 *  需要显示和配置的gif表情对象
 */
@property (nonatomic, strong) YukeyEmotion *emotion;
@end

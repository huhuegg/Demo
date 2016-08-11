//
//  YukeyEmotionCollectionViewFlowLayout.m
//  TestMessageKit
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "YukeyEmotionCollectionViewFlowLayout.h"
#import "YukeyEmotionManager.h"

@implementation YukeyEmotionCollectionViewFlowLayout
- (id)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(kXHEmotionImageViewSize, kXHEmotionImageViewSize);
        self.minimumLineSpacing = kXHEmotionMinimumLineSpacing;
        self.sectionInset = UIEdgeInsetsMake(kXHEmotionMinimumLineSpacing - 4, kXHEmotionMinimumLineSpacing, 0, kXHEmotionMinimumLineSpacing);
        self.collectionView.alwaysBounceVertical = YES;
    }
    return self;
}
@end

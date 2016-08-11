//
//  YukeyPhotographyHelper.h
//  TestMessageKit
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^DidFinishTakeMediaCompledBlock)(UIImage *image, NSDictionary *editingInfo);
@interface YukeyPhotographyHelper : NSObject
- (void)showOnPickerViewControllerSourceType:(UIImagePickerControllerSourceType)sourceType onViewController:(UIViewController *)viewController compled:(DidFinishTakeMediaCompledBlock)compled;
@end

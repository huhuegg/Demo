//
//  AllWebViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-17.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WebType) {
    WebType_Exchange = 0,
    WebType_Search,
};

@interface AllWebViewController : UIViewController

-(id)init:(NSString *)url withType:(WebType)webtype details:(NSDictionary *)details;
@end

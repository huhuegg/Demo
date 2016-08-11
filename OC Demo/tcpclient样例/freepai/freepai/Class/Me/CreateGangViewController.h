//
//  CreateGangViewController.h
//  freepai_client
//
//  Created by jiangchao on 14-5-27.
//  Copyright (c) 2014年 yunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateGangViewControllerdelegate <NSObject>

-(void)createGang:(NSString *)name;
@end

@interface CreateGangViewController : UIViewController
@property (nonatomic) id<CreateGangViewControllerdelegate>delegate;
@property (nonatomic,strong) UITextField *Name_Field;

@end

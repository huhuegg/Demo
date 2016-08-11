//
//  AddMyInfoViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AddMyAccount = 0,
    AddMyAddress = 1,
    AddMyQuanZi = 2,
    SearchQuanZi = 3,
} AddMyInfoStyle;

@protocol AddMyInfoViewControllerDelegate <NSObject>
@optional
-(void)addAccount:(NSString *)account;
-(void)addAddressWithPerson:(NSString *)person PostCode:(NSString *)postcode Tele:(NSString *)telephone Area:(NSString *)area Location:(NSString *)location;
-(void)addQuanZi:(NSString *)quanzi;
-(void)searchQuanZi:(NSString *)quanzi;
@end

@interface AddMyInfoViewController : UIViewController
@property (nonatomic) AddMyInfoStyle myStyle;
@property (nonatomic,strong) UITextField *accountName_Field;
@property (nonatomic,strong) UITextField *person_Field;
@property (nonatomic,strong) UITextField *postcode_Field;
@property (nonatomic,strong) UITextField *telephone_Field;
@property (nonatomic,strong) UITextField *area_Field;
@property (nonatomic,strong) UITextField *location_Field;
@property (nonatomic,strong) UITextField *quanzi_Field;
@property (nonatomic,strong) UITextField *SearchQuanZi_Field;
@property (nonatomic,strong) id<AddMyInfoViewControllerDelegate> delegate;
- (id)init:(AddMyInfoStyle)style;
@end

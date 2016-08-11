//
//  Me_PersonalInfoView.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol Me_PersonalInfoViewDelegate <NSObject>

@required
-(void)personalInfoHeadButtonTouch;
-(void)personalInfoAccountButtonTouch;
-(void)personalInfoPartyButtonTouch;
-(void)personalInfoRealNameButtonTouch;
-(void)personalInfoIDButtonTouch;

@end

@interface Me_PersonalInfoView : UIView

//头像
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIButton *headButton;
//昵称
@property (nonatomic,strong) UILabel *accountTitle;
@property (nonatomic,strong) UIButton *accountButton;
//自建帮派
@property (nonatomic,strong) UILabel *partyTitle;
@property (nonatomic,strong) UIButton *partyButton;
//真实姓名
@property (nonatomic,strong) UILabel *realNameTitle;
@property (nonatomic,strong) UIButton *realNameButton;
//身份证号
@property (nonatomic,strong) UILabel *idTitle;
@property (nonatomic,strong) UIButton *idButton;

@property (nonatomic,strong) id<Me_PersonalInfoViewDelegate>delegate;

@end

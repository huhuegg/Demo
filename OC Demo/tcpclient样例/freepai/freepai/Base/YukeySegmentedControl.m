//
//  YukeySegmentedControl.m
//  TestInterface
//
//  Created by jiangchao on 14-6-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "YukeySegmentedControl.h"

@implementation YukeySegmentedControl

- (id)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle centerTitle:(NSString *)centerTitle rightTitle:(NSString *)rightTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.leftButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton.frame = CGRectMake(8,0, 100, 30);
        self.leftButton.backgroundColor = [UIColor clearColor];
        self.leftButton.tag = 1;
        [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
        self.leftButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
        [self.leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.leftButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [self.leftButton addTarget:self action:@selector(btn_touch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.leftButton];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(110, 4, 2, 22)];
        line1.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line1];
        
        self.centerButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.centerButton.frame = CGRectMake(112,0, 100, 30);
        self.centerButton.backgroundColor = [UIColor clearColor];
        self.centerButton.tag = 2;
        [self.centerButton setTitle:centerTitle forState:UIControlStateNormal];
        self.centerButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
        [self.centerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.centerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [self.centerButton addTarget:self action:@selector(btn_touch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.centerButton];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(214, 4, 2, 22)];
        line2.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line2];
        
        self.rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton.frame = CGRectMake(214,0, 100, 30);
        self.rightButton.backgroundColor = [UIColor clearColor];
        [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];
        self.rightButton.tag = 3;
        self.rightButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
        [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.rightButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [self.rightButton addTarget:self action:@selector(btn_touch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];
       
    }
    return self;
}

-(void)btn_touch:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)sender;
        if (button.tag == 1) {
            self.leftButton.selected = YES;
            self.centerButton.selected = NO;
            self.rightButton.selected = NO;
        }else if (button.tag == 2){
            self.leftButton.selected = NO;
            self.centerButton.selected = YES;
            self.rightButton.selected = NO;
        }else if (button.tag == 3){
            self.leftButton.selected = NO;
            self.centerButton.selected = NO;
            self.rightButton.selected = YES;
        }
        [self.delegate selectedButton:button];
    }
}

@end

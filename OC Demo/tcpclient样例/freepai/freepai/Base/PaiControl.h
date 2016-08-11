//
//  PaiControl.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    PaiControlTypeWeb,
    PaiControlTypeApp
} PaiControlType;

typedef enum {
    PaiControlStatusEnabled,
    PaiControlStatusDisabled
} PaiControlStatus;

@class PaiControl;

@interface PaiControl : UIControl
@property (nonatomic) PaiControlStatus paistatus;
@property (nonatomic) PaiControlType paitype;
@property (nonatomic,strong) NSString *changeURL;

-(id)initWithFrame:(CGRect)frame withUrl:(NSString *)Url mainImage:(UIImage *)mainimage  rightTopImage:(UIImage *)rightTopimage PaiType:(PaiControlType)type PaiStatus:(PaiControlStatus)status;

@end

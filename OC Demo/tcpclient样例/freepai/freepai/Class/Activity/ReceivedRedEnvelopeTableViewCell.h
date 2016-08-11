//
//  ReceivedRedEnvelopeTableViewCell.h
//  freepai
//
//  Created by admin on 14/6/26.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recvRedEnvelopeButton.h"

@interface ReceivedRedEnvelopeTableViewCell : UITableViewCell
@property (nonatomic,strong)UILabel *sendInfo;
@property (nonatomic,strong)recvRedEnvelopeButton *recvButton;
@property (nonatomic,strong)UILabel *recvInfo;
@end

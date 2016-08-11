//
//  DataConstraintsProtocol.h
//  try
//
//  Created by huhuegg on 14-5-30.
//  Copyright (c) 2014年 huhuegg. All rights reserved.
//

/*
 数据约束协议,部分数据代理需满足此协议
 */

#import <Foundation/Foundation.h>

@protocol DataConstraintsProtocol <NSObject>

@required
-(void)save;
-(void)load;
@end

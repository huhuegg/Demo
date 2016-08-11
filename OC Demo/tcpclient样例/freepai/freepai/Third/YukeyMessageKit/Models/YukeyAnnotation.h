//
//  YukeyAnnotation.h
//  TestMessageKit
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface YukeyAnnotation : NSObject <MKAnnotation>

/**
 *  实现MKAnnotation协议必须要定义这个属性
 */
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  子标题
 */
@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) CLRegion *region;

@property (nonatomic, readwrite) CLLocationDistance radius;

- (id)initWithCLRegion:(CLRegion *)newRegion title:(NSString *)title subtitle:(NSString *)subtitle;

@end

//
//  OrderSpeedModel.h
//  AoYangBuild
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderSpeedModel : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *detailTitle;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *price;
+(instancetype)modelWithDic:(NSDictionary *)dic;

@end

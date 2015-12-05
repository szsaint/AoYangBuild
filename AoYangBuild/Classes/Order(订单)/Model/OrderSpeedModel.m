//
//  OrderSpeedModel.m
//  AoYangBuild
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "OrderSpeedModel.h"

@implementation OrderSpeedModel
+(instancetype)modelWithDic:(NSDictionary *)dic{
    OrderSpeedModel *model =[[OrderSpeedModel alloc]init];
    NSString *title =dic[@"post_title"];
    NSString *detailtitle =dic[@"post_content"];
    NSString *price =dic[@"amount"];
    NSString *time =dic[@"post_date"];
    if (time) {
        model.time=time;
    }
    if (title) {
        model.title=title;
    }
    if (detailtitle) {
        model.detailTitle=detailtitle;
    }
    if (price) {
        model.price=price;
    }
    return model;
}
@end

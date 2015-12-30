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
    NSString *post_name =dic[@"post_name"];
    NSString *ID =dic[@"id"];
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
    if (post_name) {
        model.post_name =post_name;
    }
    if (ID) {
        model.ID=ID;
    }
    return model;
}
@end

//
//  AYAticleModel.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYAticleModel.h"

@implementation AYAticleModel
+(instancetype)articleModelWithDic:(NSDictionary *)dic{
    AYAticleModel *model =[[AYAticleModel alloc]init];

    if (dic[@"featured_image"]!=[NSNull null]) {
        NSDictionary *source =dic[@"featured_image"];
        model.imageName=source[@"source"];
        model.imageType=1;
        
    }else{
        model.imageType=0;
    }
    NSString *excerptStr =dic[@"excerpt"];
    if (excerptStr.length>8) {
        NSString *one = [excerptStr substringFromIndex:3];
        NSString *two =[one substringToIndex:one.length-5];
        model.subtitle=two;
    }else{
        model.subtitle=excerptStr;
    }
    model.title =dic[@"title"];
    NSString *timeStr =dic[@"date"];
    NSString *str = [timeStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    model.time=str;
    model.business=nil;
    model.commentCount=nil;
    return model;
}
@end

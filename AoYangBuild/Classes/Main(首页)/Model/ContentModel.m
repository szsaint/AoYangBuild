//
//  ContentModel.m
//  AoYangBuild
//
//  Created by wl on 15/11/9.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "ContentModel.h"

@implementation ContentModel
+(instancetype)contentModelWithDic:(NSDictionary *)dic{
    ContentModel *model =[[ContentModel alloc]init];
    if ([dic[@"author"] isKindOfClass:[NSNumber class]]) {
        model.userName=@"火星人";
        model.userIcon=nil;
    }else{
        NSDictionary *userDic =dic[@"author"];
        model.userName=userDic[@"nickname"];
        model.userIcon=userDic[@"avatar"];

    }
    NSString *time=dic[@"date"];
    NSString *str = [time stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    model.time=str;
    NSString *contentStr =dic[@"content"];
    NSString *one = [contentStr substringFromIndex:3];
    NSString *two =[one substringToIndex:one.length-5];
    model.content=two;
    return model;
}
@end

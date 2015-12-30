//
//  UserInfoModel.m
//  AoYangBuild
//
//  Created by wl on 15/12/16.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel
+(instancetype)UserInfoWithDic:(NSDictionary *)dic{
    UserInfoModel *model =[[UserInfoModel alloc]init];
    model.mobile =dic[@"mobile"];
    model.display_name =dic[@"display_name"];
    UserCompany *company =[[UserCompany alloc]init];
    NSDictionary *comdic = dic[@"user_company"];
    NSDictionary *realcomdic =comdic[comdic.allKeys[0]];
    company.name =realcomdic[@"name"];
    company.phone =realcomdic[@"phone"];
    model.user_company =company;
    return model;
}
@end


@implementation UserCompany
@end
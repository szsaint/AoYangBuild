//
//  WaitAplicationModel.m
//  AoYangBuild
//
//  Created by wl on 15/12/3.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "WaitAplicationModel.h"

@implementation WaitAplicationModel
+(instancetype)aplicationModelWithDic:(NSDictionary *)dic{
    WaitAplicationModel *model =[[WaitAplicationModel alloc]init];
    NSDictionary *userDic =dic[@"user"];
    NSString *username =userDic[@"user_login"];
    NSString *approved =dic[@"apporved"];
    NSString *ID =dic[@"id"];
    model.name=username;
    model.state =[approved integerValue];
    model.ID=ID;
    return model;
}
@end

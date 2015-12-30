//
//  UserInfoModel.h
//  AoYangBuild
//
//  Created by wl on 15/12/16.
//  Copyright © 2015年 saint. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface UserCompany:NSObject
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *name;
@end
@interface UserInfoModel : NSObject
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *display_name;
@property (nonatomic,strong)UserCompany *user_company;
+(instancetype)UserInfoWithDic:(NSDictionary *)dic;
@end

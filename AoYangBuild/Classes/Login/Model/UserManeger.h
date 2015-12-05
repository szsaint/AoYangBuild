//
//  UserManeger.h
//  AoYangBuild
//
//  Created by wl on 15/11/28.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManeger : NSObject
//保存用户信息
-(void)saveUserName:(NSString *)username andPassWord:(NSString *)passWord company:(BOOL)company;


//删除用户信息
-(void)deleteUserInfo;


//保存登陆信息
+(void)saveUserLoginInfo:(NSDictionary *)dic baseKey:(NSString *)basekey;

@end

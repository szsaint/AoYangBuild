//
//  UserManeger.m
//  AoYangBuild
//
//  Created by wl on 15/11/28.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "UserManeger.h"

@implementation UserManeger
-(void)saveUserName:(NSString *)username andPassWord:(NSString *)passWord  company:(BOOL)company{
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *u =username;
    NSString *p = passWord;
    NSString *loginString = [NSString stringWithFormat:@"%@:%@",u,p];
    NSData *loginData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64LoginString =[NSString stringWithFormat:@"Basic %@",[loginData base64EncodedStringWithOptions:0]];
    [user setValue:username forKey:@"username"];
    [user setValue:passWord forKey:@"password"];
    if (company==YES) {
        [user setValue:@"company" forKey:@"company"];
    }
    [user setValue:base64LoginString forKey:@"basekey"];
    [user synchronize];

}

-(void)deleteUserInfo{
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"username"];
    [user removeObjectForKey:@"basekey"];
    [user removeObjectForKey:@"company"];
    [user removeObjectForKey:@"companyname"];
    [user removeObjectForKey:@"avatar"];
    [user removeObjectForKey:@"uid"];
    [user removeObjectForKey:@"nickname"];
    [user removeObjectForKey:@"companyID"];
    [user removeObjectForKey:@"mobile"];
    [user synchronize];
    
}

+(void)saveUserLoginInfo:(NSDictionary *)dic baseKey:(NSString *)basekey{
    
    //username  ID  avatar roles basekey
    NSString *username =dic[@"username"];//user_login登陆的账号
    NSString *ID = [NSString stringWithFormat:@"%@",dic[@"ID"]];
    NSString *nickname =dic[@"nickname"];
    NSString *company;
    NSArray *roles =dic[@"roles"];
    for (NSString *type in roles) {
        if ([type isEqualToString:@"contributor"]) {
            company =@"company";//公司管理者
        }
    }
    
    NSString *avatar =dic[@"avatar"];
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    [user setValue:username forKey:@"username"];
    if (company) {
        [user setValue:@"company" forKey:@"company"];
    }
    
    NSDictionary *metadic =dic[@"meta"];
    if ([metadic valueForKey:@"user_company"]!=[NSNull null]&&![[metadic valueForKey:@"user_company"] isKindOfClass:[NSString class]]) {
        NSDictionary *companyDic =metadic[@"user_company"];
        NSString *companyname =companyDic[@"name"];
        NSString *companyID =companyDic[@"id"];
        [user setValue:companyname forKey:@"companyname"];
        [user setValue:companyID forKey:@"companyID"];
    }
    NSString *mobile =[metadic valueForKey:@"mobile"];
    if (mobile.length>0) {
        [user setValue:mobile forKey:@"mobile"];
    }
    [user setValue:basekey forKey:@"basekey"];
    [user setValue:ID forKey:@"uid"];
    [user setValue:avatar forKey:@"avatar"];
    [user setValue:nickname forKey:@"nickname"];
    [user synchronize];

}

//-(NSDictionary *)requestHeaderFieldValueDictionary{
//    NSString * username = @"13813813138";
//    NSString *password = @"13813813138";
//    NSString *loginString = [NSString stringWithFormat:@"%@:%@",username,password];
//    NSData *loginData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *base64LoginString =[NSString stringWithFormat:@"Basic %@",[loginData base64EncodedStringWithOptions:0]];
//    return [[NSDictionary alloc] initWithObjects:@[base64LoginString] forKeys:@[@"Authorization"]];
//}
@end

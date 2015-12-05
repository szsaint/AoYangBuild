//
//  UserInfoApi.m
//  AoYangBuild
//
//  Created by wl on 15/11/27.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "UserInfoApi.h"

@implementation UserInfoApi
{
    NSString *_base64LoginString;
}
-(id)initWithUserName:(NSString *)username password:(NSString *)password{
    if (self=[super init]) {
        NSString *u =username;
        NSString *p = password;
        NSString *loginString = [NSString stringWithFormat:@"%@:%@",u,p];
        NSData *loginData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
         _base64LoginString =[NSString stringWithFormat:@"Basic %@",[loginData base64EncodedStringWithOptions:0]];
    }
    return self;
}
-(id)responseJSONObject{
    return self.requestOperation.responseObject;
}
-(NSString *)requestUrl{
    return @"/users/me";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGet;
}
-(NSDictionary *)requestHeaderFieldValueDictionary{
    return [[NSDictionary alloc] initWithObjects:@[_base64LoginString] forKeys:@[@"Authorization"]];
}
@end

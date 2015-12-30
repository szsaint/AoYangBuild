//
//  GuardSearchApi.m
//  AoYangBuild
//
//  Created by wl on 15/12/16.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "GuardSearchApi.h"

@implementation GuardSearchApi
{
    NSString  *_Uid;
}
-(instancetype)initWithUid:(NSString *)Uid{
    if (self =[super init]) {
        _Uid =Uid;
    }
    return self;
}
-(id)responseJSONObject{
    return self.requestOperation.responseObject;
}
-(NSDictionary *)requestHeaderFieldValueDictionary{
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *base64LoginString =[user objectForKey:@"basekey"];
    if (!base64LoginString) {
        return nil;
    }
    return [[NSDictionary alloc] initWithObjects:@[base64LoginString] forKeys:@[@"Authorization"]];
}
-(NSString *)requestUrl{
    return [NSString stringWithFormat:@"/pods/user/%@",_Uid];
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGet;
}
-(id)requestArgument{
    return nil;
}

@end

//
//  ChargeApi.m
//  AoYangBuild
//
//  Created by wl on 15/12/3.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "ChargeApi.h"

@implementation ChargeApi{
    NSDictionary *_param;
}
-(id)initHad{
    if (self=[super init]) {
        _param =@{@"data[finished]":@"1"};
    }
    return self;
}
-(id)initWithNeed{
    if (self=[super init]) {
        _param =@{@"data[finished]":@"0"};
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
    return @"/pods/bill";
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGet;
}
-(id)requestArgument{
    return _param;
}
@end

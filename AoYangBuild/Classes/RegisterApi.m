//
//  RegisterApi.m
//  AoYangBuild
//
//  Created by wl on 15/11/27.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi{
    NSDictionary *_param;
}
-(id)initWithParam:(NSDictionary *)param{
    if (self=[super init]) {
        _param=param;
    }
    return self;
}
-(id)responseJSONObject{
    return self.requestOperation.responseObject;
}
-(NSString *)requestUrl{
    return @"/users/register";
//http://112.80.40.185/wp-json/users/register POST
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}
-(id)requestArgument{
    return _param;
}
@end

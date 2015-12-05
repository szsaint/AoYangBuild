//
//  ReSetUserInfoApi.m
//  AoYangBuild
//
//  Created by wl on 15/12/4.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "ReSetUserInfoApi.h"

@implementation ReSetUserInfoApi{
    NSDictionary *_param;
}
-(instancetype)initWithNickname:(NSString *)nickname{
    if (self=[super init]) {
        _param =@{@"nickname":nickname,@"display_name":nickname};
    }
    return self;
}
-(instancetype)initWithPhone:(NSString *)phone{
    if (self=[super init]) {
        _param =@{@"mobile":phone};
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
    NSString *userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
    return [NSString stringWithFormat:@"/pods/user/%@",userID];
    //http://112.80.40.185/wp-json/pods/user/<id>
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}
-(id)requestArgument{
    return _param;
}
@end

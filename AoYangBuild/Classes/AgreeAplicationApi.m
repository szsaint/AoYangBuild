//
//  AgreeAplicationApi.m
//  AoYangBuild
//
//  Created by wl on 15/12/3.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AgreeAplicationApi.h"

@implementation AgreeAplicationApi{
    NSString *_ID;
    NSDictionary *_param;
}
-(instancetype)initWithID:(NSString *)ID{
    if(self=[super init]) {
        _ID =ID;
        _param=@{@"approved":@"1"};
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
    return [NSString stringWithFormat:@"/pods/application/%@",_ID];
    //http://112.80.40.185/wp-json/pods/application/<id> PUT
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodPut;
}
-(id)requestArgument{
    return _param;
}

@end

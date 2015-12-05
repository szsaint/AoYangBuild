//
//  NewOrAplicationApi.m
//  AoYangBuild
//
//  Created by wl on 15/11/27.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "NewOrAplicationApi.h"

@implementation NewOrAplicationApi{
    NSDictionary *_param;
    BOOL company;
    BOOL nothing;
}
-(id)initWithCompanyID:(NSString *)ID{
    if ( self=[super init]) {
        NSString *user =[[NSUserDefaults standardUserDefaults]valueForKey:@"uid"];
        _param =@{@"company":ID,@"user":user};
    }
    return self;
}
-(id)initWithCompanyName:(NSString *)name phone:(NSString *)phone brief:(NSString *)brief{
    if (self =[super init]) {
        if (!phone&&!brief) {
            _param =@{@"name":name};
        }else if (!phone){
            _param =@{@"name":name,@"brief":brief};

        }else if (!brief){
            _param =@{@"name":name,@"phone":phone};
        }else{
            _param =@{@"name":name,@"phone":phone,@"brief":brief};
        }
        company=YES;
    }
    return self;
}
-(id)initWithNothing{
    if (self=[super init]) {
        nothing=YES;
    }
    return self;
}
-(id)responseJSONObject{
    return self.requestOperation.responseObject;
}
-(NSString *)requestUrl{
    if (company) {
        return @"/pods/company";
    }else{
        return @"/pods/application";
    }
    return nil;
}
-(id)requestArgument{
    if (nothing) {
        return _param;
    }
    return _param;
}
-(YTKRequestMethod)requestMethod{
    if (nothing) {
        return YTKRequestMethodGet;
    }
    return YTKRequestMethodPost;
}
-(NSDictionary *)requestHeaderFieldValueDictionary{
    NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
    NSString *base64LoginString =[user objectForKey:@"basekey"];
    if (!base64LoginString) {
        return nil;
    }
    return [[NSDictionary alloc] initWithObjects:@[base64LoginString] forKeys:@[@"Authorization"]];
}

@end

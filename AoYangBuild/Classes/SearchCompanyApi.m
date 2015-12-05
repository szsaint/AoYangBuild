//
//  SearchCompanyApi.m
//  AoYangBuild
//
//  Created by wl on 15/11/27.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "SearchCompanyApi.h"

@implementation SearchCompanyApi{
    NSString *_company;
}
-(id)initWithCompany:(NSString *)company{
    if (self=[super init]) {
        _company=company;
    }
    return self;
}
-(id)responseJSONObject{
    return self.requestOperation.responseObject;
}
-(NSString *)requestUrl{
    if (_company) {
        return [NSString stringWithFormat:@"/pods/company/%@",_company];
    }else{
        return @"/pods/company";}
//http://112.80.40.185/wp-json/company GET
}
-(YTKRequestMethod)requestMethod{
    return YTKRequestMethodGet;
}
-(id)requestArgument{
    return nil;
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

//
//  ReSetUserInfoApi.h
//  AoYangBuild
//
//  Created by wl on 15/12/4.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "YTKRequest.h"

@interface ReSetUserInfoApi : YTKRequest
-(instancetype)initWithPhone:(NSString *)phone;
-(instancetype)initWithNickname:(NSString *)nickname;
-(id)responseJSONObject;

@end

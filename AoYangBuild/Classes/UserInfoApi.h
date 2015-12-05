//
//  UserInfoApi.h
//  AoYangBuild
//
//  Created by wl on 15/11/27.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "YTKRequest.h"

@interface UserInfoApi : YTKRequest
-(instancetype)initWithUserName:(NSString *)username password:(NSString *)password;
-(id)responseJSONObject;
@end

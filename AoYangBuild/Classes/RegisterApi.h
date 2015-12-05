//
//  RegisterApi.h
//  AoYangBuild
//
//  Created by wl on 15/11/27.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "YTKRequest.h"

@interface RegisterApi : YTKRequest
-(id)initWithParam:(NSDictionary *)param;
-(id)responseJSONObject;

@end

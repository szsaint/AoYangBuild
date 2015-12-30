//
//  GuardSearchApi.h
//  AoYangBuild
//
//  Created by wl on 15/12/16.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "YTKRequest.h"

@interface GuardSearchApi : YTKRequest
-(instancetype)initWithUid:(NSString *)Uid;
-(id)responseJSONObject;
@end

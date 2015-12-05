//
//  AgreeAplicationApi.h
//  AoYangBuild
//
//  Created by wl on 15/12/3.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "YTKRequest.h"

@interface AgreeAplicationApi : YTKRequest
-(instancetype)initWithID:(NSString *)ID;
-(id)responseJSONObject;
@end

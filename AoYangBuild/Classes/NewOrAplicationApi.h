//
//  NewOrAplicationApi.h
//  AoYangBuild
//
//  Created by wl on 15/11/27.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "YTKRequest.h"

@interface NewOrAplicationApi : YTKRequest
-(id)initWithCompanyID:(NSString *)ID;
-(id)responseJSONObject;
-(id)initWithCompanyName:(NSString *)name phone:(NSString *)phone brief:(NSString *)brief;
-(id)initWithNothing;
@end

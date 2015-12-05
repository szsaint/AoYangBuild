//
//  SearchCompanyApi.h
//  AoYangBuild
//
//  Created by wl on 15/11/27.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "YTKRequest.h"

@interface SearchCompanyApi : YTKRequest
-(id)initWithCompany:(NSString *)company;
-(id)responseJSONObject;
@end

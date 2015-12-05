//
//  NewsApi.h
//  AoYangBuild
//
//  Created by wl on 15/11/26.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "YTKRequest.h"
@interface NewsApi : YTKRequest
//通知 公告 幻灯片
- (id) initWithItem:(NSString *)item andPage:(NSInteger)page;

- (id) responseJSONObject;

//某个文章评论
- (id) initWithNewsID:(NSString *)ID andPage:(NSInteger)page;
- (id) initWithComment:(NSString *)comment andNewsID:(NSString *)ID;
@end

//
//  ContentModel.h
//  AoYangBuild
//
//  Created by wl on 15/11/9.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContentModel : NSObject
@property (nonatomic,copy)NSString *userName;

@property (nonatomic,copy)NSString *userIcon;

@property (nonatomic,copy)NSString *time;

//@property (nonatomic,assign)BOOL thumb;//赞

//@property (nonatomic,copy)NSString *thumbCount;

@property (nonatomic,copy)NSString *content;
+(instancetype)contentModelWithDic:(NSDictionary *)dic;
@end

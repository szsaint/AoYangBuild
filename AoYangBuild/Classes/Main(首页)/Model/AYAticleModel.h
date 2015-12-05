//
//  AYAticleModel.h
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AYAticleModel : NSObject
@property(nonatomic,assign)NSInteger imageType;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *business;
@property(nonatomic,copy)NSString *commentCount;
@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *imageName;
@property (nonatomic,copy)NSString *subtitle;

+(instancetype)articleModelWithDic:(NSDictionary *)dic;

@end

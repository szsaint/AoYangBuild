//
//  WaitAplicationModel.h
//  AoYangBuild
//
//  Created by wl on 15/12/3.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaitAplicationModel : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,assign)NSInteger state;

+(instancetype)aplicationModelWithDic:(NSDictionary *)dic;
@end

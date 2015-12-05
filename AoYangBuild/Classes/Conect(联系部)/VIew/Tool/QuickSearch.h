//
//  QuickSearch.h
//  AoYangBuild
//
//  Created by wl on 15/10/23.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuickSearch : NSObject
+(NSArray *)useQuickSearch:(NSArray *)dataArray keyStr:(NSString *)key;
+(NSArray *)searchData:(NSArray *)dataArray keyStr:(NSString *)key withLow:(NSInteger)low;
+(int)binarySearchLower:(NSArray *)dataArray keyStr:(NSString *)key withLow:(int)low withHigh:(int)high;
@end

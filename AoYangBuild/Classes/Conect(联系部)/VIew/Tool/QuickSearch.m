//
//  QuickSearch.m
//  AoYangBuild
//
//  Created by wl on 15/10/23.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "QuickSearch.h"

@implementation QuickSearch
+(NSArray *)useQuickSearch:(NSArray *)dataArray keyStr:(NSString *)key
{
    if([dataArray count] < 1) return nil;
    int low = [self binarySearchLower:dataArray keyStr:key withLow:0 withHigh:[dataArray count]-1];
    NSArray *searchArray = [self searchData:dataArray keyStr:key withLow:low];
    return searchArray;
}

+(NSArray *)searchData:(NSArray *)dataArray keyStr:(NSString *)key withLow:(NSInteger)low{
    NSMutableArray *searchArray = [[NSMutableArray alloc] init];
    BOOL isFind = NO;
    NSString *searchData = @"";
    searchData = [NSString stringWithCString:[key UTF8String] encoding:NSUTF8StringEncoding];
    if([searchData length] > 0)
    {
        for(int i=low; i<[dataArray count];i++)
        {
            BOOL result = [[dataArray objectAtIndex:i] compare:key options:NSCaseInsensitiveSearch
                                                         range:NSMakeRange(0, [key length])];
            if (result == NSOrderedSame)
            {
                [searchArray addObject:[dataArray objectAtIndex:i] ];
                isFind = YES;
            }
            if(isFind == YES && result != NSOrderedSame)
                break;
        }
    }
    return searchArray;
}

+(int)binarySearchLower:(NSArray *)dataArray keyStr:(NSString *)key withLow:(int)low withHigh:(int)high
{
    int result = -1;
    while(low <= high)
    {
        int mid = (low + high) / 2;
        BOOL find = [[dataArray objectAtIndex:mid] compare:key options:NSCaseInsensitiveSearch
                                                     range:NSMakeRange(0, [key length])];
        if(find >= 0)
        {
            result = mid;
            high = mid - 1;
        }else low = mid + 1;
    }
    return result;
}

@end

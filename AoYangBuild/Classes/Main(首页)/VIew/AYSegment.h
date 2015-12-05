//
//  AYSegment.h
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AYSegment;
@protocol AYSegmentDelgate <NSObject>

@optional
-(void)AYSegment:(AYSegment *)segment didSelectedAtIndex:(NSInteger)index;//leftindex ==0  rightindex==1

@end

@interface AYSegment : UIImageView
@property(nonatomic,weak)id<AYSegmentDelgate>delegate;


@end

//
//  AYHeaderView.h
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AYHeaderView;
@protocol AYHeaderViewDelegate <NSObject>

-(void)AYHeaderView:(AYHeaderView *)header clickOnIndex:(NSInteger)index;

@end

@interface AYHeaderView : UIView
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,weak)id<AYHeaderViewDelegate>delegate;

@end

//
//  TitleView.h
//  AoYangBuild
//
//  Created by wl on 15/12/8.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleView : UIView
@property(nonatomic,strong)UIActivityIndicatorView *animateView;
-(instancetype)initWithTitle:(NSString *)title;
@end

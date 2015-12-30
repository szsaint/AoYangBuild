//
//  TitleView.m
//  AoYangBuild
//
//  Created by wl on 15/12/8.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView{
    NSString *_title;
    UILabel *_tittleLab;
}

-(instancetype)initWithTitle:(NSString *)title{
    if (self =[super init]) {
        _title =title;
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews{
    NSDictionary *dic =@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]};
    CGSize titleS =[_title sizeWithAttributes:dic];
    _tittleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, titleS.width, 30)];
    _tittleLab.font =[UIFont boldSystemFontOfSize:17];
    _tittleLab.textColor=[UIColor whiteColor];
    _tittleLab.textAlignment=NSTextAlignmentCenter;
    _tittleLab.text=_title;
    [self addSubview:_tittleLab];
    
    UIActivityIndicatorView *animatView =[[UIActivityIndicatorView alloc]init];
    animatView.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
    self.animateView =animatView;
    [self addSubview:animatView];
    self.frame =CGRectMake(0, 0, 30+titleS.width+30, 30);
    _tittleLab.frame =CGRectMake(30, 0, titleS.width, 30);
    self.animateView.frame =CGRectMake(5, 5, 20, 20);
}

@end

//
//  AYButton.m
//  AoYangBuild
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYButton.h"
@interface AYButton ()
@property (nonatomic,weak)UIView *line1;
@property (nonatomic,weak)UIView *line2;
@end

@implementation AYButton
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews{
    self.imageView =[[UIImageView alloc]init];
    [self addSubview:self.imageView];
    
    
    self.titleLab=[[UILabel alloc]init];
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    self.titleLab.font=[UIFont systemFontOfSize:14];
    self.titleLab.textColor=[UIColor grayColor];
    [self addSubview:self.titleLab];
    
    self.line1 =[self creatLine];
    self.line2=[self creatLine];
    
}
-(UIView *)creatLine{
    UIView *line =[[UIView alloc]init];
    line.backgroundColor=[UIColor lightGrayColor];
    line.alpha=0.3;
    [self addSubview:line];
    return line;
}

-(void)layoutSubviews{
    //40 40
    CGFloat WW =self.width;
    CGFloat HH =self.height;
    self.imageView.frame=CGRectMake((WW-40)/2, HH/2-40+8, 40, 40);
    CGFloat yy =CGRectGetMaxY(self.imageView.frame);
    self.titleLab.frame =CGRectMake(0, yy, WW, self.height-yy-10);
    self.line1.frame=CGRectMake(0, HH-1, self.width, 1);
    self.line2.frame=CGRectMake(WW-1, 0, 1, HH);
    
}


@end

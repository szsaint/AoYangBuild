//
//  AYSegment.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYSegment.h"
@interface AYSegment ()
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@end

@implementation AYSegment

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.image=[UIImage imageNamed:@"Column"];
        self.backgroundColor=[UIColor clearColor];
        self.userInteractionEnabled=YES;
        _leftBtn =[[UIButton alloc]init];
        _leftBtn.highlighted=NO;
        _leftBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_leftBtn setTitle:@"文章" forState:UIControlStateNormal];
        [_leftBtn setTitle:@"文章" forState:UIControlStateDisabled];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"Category selection box"] forState:UIControlStateDisabled];
        [_leftBtn setTitleColor:RGB(50, 144, 232, 1) forState:UIControlStateDisabled];
        //[_leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [_leftBtn addTarget:self action:@selector(leftOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn.enabled=NO;
        [self addSubview:_leftBtn];
        
        
        _rightBtn=[[UIButton alloc]init];
        _rightBtn.highlighted=NO;
        _rightBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_rightBtn setTitle:@"通知" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"通知" forState:UIControlStateDisabled];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"Category selection box"] forState:UIControlStateDisabled];
        [_rightBtn setTitleColor:RGB(50, 144, 232, 1) forState:UIControlStateDisabled];
        [_rightBtn addTarget:self action:@selector(rightOnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat ww =self.width;
    CGFloat hh =self.height;
    self.leftBtn.frame=CGRectMake(0, 0, ww/2, hh);
    
    self.rightBtn.frame =CGRectMake(ww/2, 0, ww/2, hh);
}
-(void)leftOnClick:(UIButton *)sender{
    sender.enabled=NO;
    self.rightBtn.enabled=YES;
    if ([self.delegate respondsToSelector:@selector(AYSegment:didSelectedAtIndex:)]) {
        [self.delegate AYSegment:self didSelectedAtIndex:0];
    }
}

-(void)rightOnCLick:(UIButton *)sender{
    sender.enabled=NO;
    self.leftBtn.enabled=YES;
    if ([self.delegate respondsToSelector:@selector(AYSegment:didSelectedAtIndex:)]) {
        [self.delegate AYSegment:self didSelectedAtIndex:1];
    }
}











@end

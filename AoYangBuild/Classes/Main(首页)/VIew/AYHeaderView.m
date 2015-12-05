//
//  AYHeaderView.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define scrollHH  200
@interface AYHeaderView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UIImageView *labImage;
@property(nonatomic,strong)UILabel *lab;
@property(nonatomic,strong)UIPageControl *page;
@property(nonatomic,assign)NSInteger currentPage;

@property (nonatomic,strong)NSArray *titleArray;
@end

@implementation AYHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        //1.imageView
        [self setUpScrollView];
        //2.lab pic
        [self setUpLab];
        //3.pageControl
        [self setUpPageControl];
        [self addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)setArray:(NSArray *)array{
    _array=array;
    [self.scroll setContentSize:CGSizeMake(SCREEN_WIDTH*array.count, 0)];
    NSMutableArray *arrM =[NSMutableArray array];
    NSInteger count =array.count>5?5:array.count;
    for (int i=0; i<count;i++) {
        UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, 200)];
        imageV.backgroundColor= randomColor;
        [self.scroll addSubview:imageV];
        NSString *imageName;
        if ([array[i] valueForKey:@"title"]!=[NSNull null]) {
          NSString *title =[array[i] valueForKey:@"title"];
            [arrM addObject:title];
        }
        if ([array[i] valueForKey:@"featured_image"]!=[NSNull null]) {
            NSDictionary *dic =[array[i] valueForKey:@"featured_image"];
            imageName =dic[@"source"];
        }
        imageV.tag=i;
        imageV.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerOnClick:)];
        [imageV addGestureRecognizer:tap];
        [imageV sd_setImageWithURL:[NSURL URLWithString:imageName]];
    }
    self.page.numberOfPages=array.count;
    self.titleArray=arrM;
    self.lab.text=self.titleArray[0];

}
-(void)headerOnClick:(UITapGestureRecognizer *)tap{
    NSInteger index = tap.view.tag;
    if ([self.delegate respondsToSelector:@selector(AYHeaderView:clickOnIndex:)]) {
        [self.delegate AYHeaderView:self clickOnIndex:index];
    }
}
-(void)setUpScrollView{
    UIScrollView *scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.width,scrollHH)];
    scroll.pagingEnabled=YES;
    scroll.showsHorizontalScrollIndicator=NO;
    scroll.showsVerticalScrollIndicator=NO;
    self.scroll=scroll;
    self.scroll.delegate=self;
    [self addSubview:scroll];
}
-(void)setUpLab{
    UIImageView *labimage =[[UIImageView alloc]initWithFrame:CGRectMake(8, 206, 30, 17)];
    labimage.image=[UIImage imageNamed:@"headlines icon"];
    self.labImage=labimage;
    [self addSubview:labimage];
    
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(43, 206, SCREEN_WIDTH-43*2-20, 17)];
    lab.font=[UIFont systemFontOfSize:12];
   // lab.text=@"张家港圣斗士强势入驻澳洋电子产业园";
    self.lab=lab;
    [self addSubview:lab];
    
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 229.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:line];
    
}
-(void)setUpPageControl{
    UIPageControl *page =[[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, 206, 40, 17)];
    self.page=page;
    self.page.currentPage=0;
    self.page.pageIndicatorTintColor=[UIColor grayColor];
    self.page.currentPageIndicatorTintColor=appColor;
    [self addSubview:page];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offx =scrollView.contentOffset.x;
    int page =(offx+SCREEN_WIDTH*0.5)/SCREEN_WIDTH;
    if (page>self.page.numberOfPages-1||page<0)return;
    self.page.currentPage=page;
    if (self.currentPage==page) {
        return;
    }else{
        self.currentPage=page;
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSInteger page =[[change valueForKey:@"new"]integerValue];
    if (page>self.page.numberOfPages-1||page<0)return;
    self.lab.text=self.titleArray[page];
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"currentPage"];
}
@end

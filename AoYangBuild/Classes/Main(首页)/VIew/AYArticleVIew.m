//
//  AYArticleVIew.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYArticleVIew.h"
#import "AYAticleModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define   titleFont  [UIFont systemFontOfSize:14]
#define   subLabelFont  [UIFont systemFontOfSize:10]


@interface AYArticleVIew ()

//  标题label
@property (nonatomic,weak) UILabel *titleLabel;
//  企业名称label
//@property (nonatomic,weak)UILabel *businessLabel;
//  热点image
@property (nonatomic,weak)UIImageView *hotImage;
//  时间label
@property (nonatomic,weak)UILabel *timeLabel;
//  评论image
//@property (nonatomic,weak)UIImageView *commentImage;
//  评论数量label
//@property (nonatomic,weak)UILabel *commentCount;
//  第一张图片
@property (nonatomic,weak)UIImageView *firstImage;
//  第二张图片
//@property (nonatomic,weak)UIImageView *secondImage;
//  第三张图片
//@property (nonatomic,weak)UIImageView *thirdImage;
//  下划线
@property (nonatomic,weak)UIView *line;



@end

@implementation AYArticleVIew

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //添加所有的子控件
        [self setupSubView];
    }
    
    return self;
}

#pragma mark 添加所有的子控件
-(void)setupSubView
{
    //1.创建标题
    UILabel *titleLabel =[[UILabel alloc]init];
    titleLabel.font=titleFont;
    titleLabel.numberOfLines=0;
    [self addSubview:titleLabel];
    self.titleLabel=titleLabel;
    
    //创建企业名称
//    UILabel *businessLabel =[[UILabel alloc]init];
//    businessLabel.font=subLabelFont;
//    businessLabel.textColor=[UIColor lightGrayColor];
//    [self addSubview:businessLabel];
//    self.businessLabel =businessLabel;
    
    //创建热点Image
    UIImageView *hotImage =[[UIImageView alloc]init];
    hotImage.image =[UIImage imageNamed:@"Popular icon"];
    self.hotImage=hotImage;
    [self addSubview:hotImage];
    
    //创建时间
    UILabel *timeLabel =[[UILabel alloc]init];
    timeLabel.font=subLabelFont;
    timeLabel.textColor=[UIColor lightGrayColor];
    self.timeLabel=timeLabel;
    [self addSubview:timeLabel];
    
    //创建评论图
//    UIImageView *commentImage =[[UIImageView alloc]init];
//    commentImage.image =[UIImage imageNamed:@"Comment icon"];
//    [self addSubview:commentImage];
//    self.commentImage=commentImage;
    
    //创建评论数
//    UILabel *commentCount =[[UILabel alloc]init];
//    commentCount.textAlignment=NSTextAlignmentCenter;
//    commentCount.font =subLabelFont;
//    commentCount.textColor=[UIColor lightGrayColor];
//    [self addSubview:commentCount];
//    self.commentCount=commentCount;
    
    //创建第一张图片
    UIImageView *firstImage =[[UIImageView alloc]init];
    [self addSubview:firstImage];
    self.firstImage=firstImage;
    self.firstImage.contentMode=UIViewContentModeScaleAspectFill;
    self.firstImage.layer.masksToBounds=YES;
    //创建第二张图
//    UIImageView *secondImage =[[UIImageView alloc]init];
//    [self addSubview:secondImage];
//    self.secondImage=secondImage;
//    self.secondImage.contentMode=UIViewContentModeScaleAspectFill;
//    self.secondImage.layer.masksToBounds=YES;

    
    //创建第三张图
//    UIImageView *thidImage =[[UIImageView alloc]init];
//    [self addSubview:thidImage];
//    self.thirdImage=thidImage;
//    self.thirdImage.contentMode=UIViewContentModeScaleAspectFill;
//    self.thirdImage.layer.masksToBounds=YES;

    
    //创建下划线
    UIView *line= [[UIView alloc]init];
    line.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:line];
    self.line=line;
    
}


-(void)setFrameModel:(AYArticleFrameModel *)frameModel{
    _frameModel=frameModel;
    if (frameModel.model.imageType==0) {
        //无图
        [self nopic];
    }else if (frameModel.model.imageType==1){
        //一图
        [self onePic];
    }else{
        //多图
       // [self morPic];
    }
}
#pragma mark 如果是多张图片显示

#pragma mark 正常状态下显示
-(void)nopic{
    self.frame =self.frameModel.articleF;
    self.titleLabel.frame=self.frameModel.titleF;
    //NSLog(@"----%@---",self.frameModel.model.title);
    self.titleLabel.text=self.frameModel.model.title;
    
    self.hotImage.frame=self.frameModel.hotimageF;
    
//    self.businessLabel.frame=self.frameModel.businessF;
//    self.businessLabel.text=self.frameModel.model.business;
    
    self.timeLabel.frame=self.frameModel.timeF;
    self.timeLabel.text=self.frameModel.model.time;
    
//    self.commentCount.frame=self.frameModel.commentCountF;
//    self.commentCount.text=self.frameModel.model.commentCount;
//    
  //  self.commentImage.frame=self.frameModel.commentImageF;
    self.line.frame=self.frameModel.lineF;
}
-(void)onePic{
    self.frame =self.frameModel.articleF;
    self.titleLabel.frame=self.frameModel.titleF;
    self.titleLabel.text=self.frameModel.model.title;
    
    self.hotImage.frame=self.frameModel.hotimageF;
    
//    self.businessLabel.frame=self.frameModel.businessF;
//    self.businessLabel.text=self.frameModel.model.business;
    
    self.timeLabel.frame=self.frameModel.timeF;
    self.timeLabel.text=self.frameModel.model.time;
    
//    self.commentCount.frame=self.frameModel.commentCountF;
//    self.commentCount.text=self.frameModel.model.commentCount;
    
//    self.commentImage.frame=self.frameModel.commentImageF;
    self.line.frame=self.frameModel.lineF;
    
    self.firstImage.frame=self.frameModel.firstImageF;
    [self.firstImage sd_setImageWithURL:[NSURL URLWithString:self.frameModel.model.imageName]];
    
}
//-(void)morPic{
//    self.frame =self.frameModel.articleF;
//    self.titleLabel.frame=self.frameModel.titleF;
//    self.titleLabel.text=self.frameModel.model.title;
//    
//    self.hotImage.frame=self.frameModel.hotimageF;
//    
//    self.businessLabel.frame=self.frameModel.businessF;
//    self.businessLabel.text=self.frameModel.model.business;
//    
//    self.timeLabel.frame=self.frameModel.timeF;
//    self.timeLabel.text=self.frameModel.model.time;
//    
//    self.commentCount.frame=self.frameModel.commentCountF;
//    self.commentCount.text=self.frameModel.model.commentCount;
//    
//    self.commentImage.frame=self.frameModel.commentImageF;
//    self.line.frame=self.frameModel.lineF;
//    
//    self.firstImage.frame=self.frameModel.firstImageF;
//    self.firstImage.backgroundColor=[UIColor redColor];
//    self.firstImage.image =[UIImage imageNamed:@"黑车"];
//
//    self.secondImage.frame=self.frameModel.secondImageF;
//    //self.secondImage.backgroundColor=[UIColor redColor];
//
//    self.secondImage.image =[UIImage imageNamed:@"黑车"];
//    
//    
//    self.thirdImage.frame=self.frameModel.thirdImageF;
//    self.thirdImage.image =[UIImage imageNamed:@"黑车"];
//
//
//}

@end

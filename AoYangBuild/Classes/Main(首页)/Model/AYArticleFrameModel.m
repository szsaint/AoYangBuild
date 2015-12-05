//
//  AYArticleFrameModel.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYArticleFrameModel.h"
#define   titleFont  [UIFont systemFontOfSize:14]
#define   subLabelFont  [UIFont systemFontOfSize:10]
#define marginTop  15
#define marginLeft 10
#define miniImgMargin 5  //图片之间的间距

//常态下图片的宽度和高度
#define normalImgW  100
#define normalImgH 80
//多张图片状态下得宽度和高度
#define moreImgW
#define moreImgH


@implementation AYArticleFrameModel
-(void)setModel:(AYAticleModel *)model{
    _model =model;
    if (model.imageType==0) {
        //无图
        [self NoImage];
    }else if (model.imageType==1){
        //单张图
        [self OneImage];
    }else{
        //多张图
        [self threeAndMoreImage];
    }
}

-(void)NoImage{
    //_articleF =CGRectMake(0, 0, SCREEN_WIDTH, 80);
    
    //标题的frame
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:titleFont,NSFontAttributeName, nil];
    CGSize textSize= [self.model.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-2*marginLeft,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:Nil].size;
    _titleF =CGRectMake(marginLeft, marginTop, SCREEN_WIDTH-2*marginLeft, textSize.height);
    
    //热点图片 企业名称
    CGFloat YY =CGRectGetMaxY(_titleF)+15;
    _hotimageF =CGRectMake(marginLeft, YY, 16, 14);
    //CGSize titleS=[self.model.business sizeWithAttributes:@{NSFontAttributeName:subLabelFont}];
    //_businessF =CGRectMake(marginLeft+16+5,YY,titleS.width, 14);
    _timeF =CGRectMake(marginLeft+10+14, YY, SCREEN_WIDTH-2*marginLeft-10-14, 14);
    
    //评论图片  数量
//    _commentImageF =CGRectMake(SCREEN_WIDTH-50, YY-1, 18, 15);//SCREEN_WIDTH-marginLeft-countS.width-23
//    CGSize countS=[self.model.commentCount sizeWithAttributes:@{NSFontAttributeName:subLabelFont}];
//    _commentCountF =CGRectMake(SCREEN_WIDTH-50+18+3,YY , countS.width, 14);
    //NSLog(@"%@",NSStringFromCGRect(_commentImageF));

    _articleF =CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(_timeF)+10);
    //下划线
    _lineF =CGRectMake(marginLeft, CGRectGetMaxY(_timeF)+9.5,SCREEN_WIDTH-marginLeft, 0.5);
    
    //行高
    _cellH =CGRectGetHeight(_articleF);
    
}
-(void)OneImage{
    // 15  10
    //图片
    _firstImageF =CGRectMake(SCREEN_WIDTH-marginLeft-normalImgW, marginTop, normalImgW, normalImgH);
    //标题
    CGFloat titleWW = SCREEN_WIDTH-marginLeft-marginLeft-normalImgW-marginLeft;
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:titleFont,NSFontAttributeName, nil];
    CGSize  titleSize =[self.model.title boundingRectWithSize:CGSizeMake(titleWW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:Nil].size;
    _titleF =CGRectMake(marginLeft, marginTop, titleWW, titleSize.height);
    
    //底部企业时间 ==
    CGFloat YY =normalImgH+marginTop-14;
    _hotimageF =CGRectMake(marginLeft, YY, 16, 14);
    _timeF =CGRectMake(marginLeft+10+14, YY, SCREEN_WIDTH-2*marginLeft-10-14, 14);
    //CGSize businesS =[self.model.business sizeWithAttributes:@{NSFontAttributeName:subLabelFont}];
    //_businessF =CGRectMake(marginLeft+16+5, YY, businesS.width, 14);//调整
    //_timeF =CGRectMake(marginLeft+21+businesS.width +20, YY, 50, 14);
    
    //评论数量 图片
//    _commentImageF =CGRectMake(SCREEN_WIDTH-marginLeft-normalImgW-marginLeft-50, YY-1, 18, 15);
//    CGFloat limitX =CGRectGetMinX(_commentImageF);
//    _businessF =CGRectMake(marginLeft+16+5, YY, limitX-(marginLeft+16+5)-3, 14);
//    CGSize countS =[self.model.commentCount sizeWithAttributes:@{NSFontAttributeName:subLabelFont}];
//    _commentCountF =CGRectMake(SCREEN_WIDTH-marginLeft-normalImgW-marginLeft-50+18+3, YY, countS.width, 14);
    _articleF =CGRectMake(0, 0, SCREEN_WIDTH, marginTop+normalImgH+10);
    
    _lineF =CGRectMake(marginLeft, marginTop+normalImgH+10-1, SCREEN_WIDTH-marginLeft, 0.5);
    _cellH =CGRectGetMaxY(_articleF);
}
-(void)threeAndMoreImage{
    //15  10  8
    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:titleFont,NSFontAttributeName, nil];
    CGSize  titleSize =[self.model.title boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-2*marginLeft
, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:Nil].size;
    _titleF =CGRectMake(marginLeft, marginTop, titleSize.width, titleSize.height);
    
    CGFloat imagWW =(SCREEN_WIDTH-2*marginLeft-2*5)/3;
    CGFloat imagHH =imagWW*0.8;
    CGFloat imageY =CGRectGetMaxY(_titleF)+10;
    _firstImageF =CGRectMake(marginLeft, imageY, imagWW, imagHH);
    _secondImageF=CGRectMake(marginLeft+imagWW+5, imageY, imagWW, imagHH);
    _thirdImageF=CGRectMake(marginLeft+imagWW*2+10, imageY, imagWW, imagHH);
    
    //热点 图片
    CGFloat yy =imageY+imagHH+8;
    _hotimageF =CGRectMake(marginLeft, yy, 16, 14);
    CGSize titleS=[self.model.business sizeWithAttributes:@{NSFontAttributeName:subLabelFont}];
    _businessF =CGRectMake(marginLeft+16+5,yy,titleS.width, 14);
    _timeF =CGRectMake(marginLeft+21+titleS.width+20, yy, 50, 14);
    
    //评论图片  数量
    _commentImageF =CGRectMake(SCREEN_WIDTH-50, yy-1, 18, 15);//SCREEN_WIDTH-marginLeft-countS.width-23
    CGSize countS=[self.model.commentCount sizeWithAttributes:@{NSFontAttributeName:subLabelFont}];
    _commentCountF =CGRectMake(SCREEN_WIDTH-50+18+3,yy , countS.width, 14);
    //NSLog(@"%@",NSStringFromCGRect(_commentImageF));
    
    _articleF =CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(_commentImageF)+10);
    //下划线
    _lineF =CGRectMake(marginLeft, CGRectGetMaxY(_commentImageF)+9.5,SCREEN_WIDTH-marginLeft, 0.5);
    
    //行高
    _cellH =CGRectGetHeight(_articleF);
    
}





























@end

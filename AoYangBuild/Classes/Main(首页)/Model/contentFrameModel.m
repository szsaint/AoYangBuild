//
//  contentFrameModel.m
//  AoYangBuild
//
//  Created by wl on 15/11/9.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "contentFrameModel.h"
#import "ContentModel.h"
#define marginLeft 18
#define marginTop 20

@implementation contentFrameModel
-(void)setModel:(ContentModel *)model{
    _model=model;
    self.userIconF=CGRectMake(marginLeft, marginTop, 40, 40);
    CGFloat xx =CGRectGetMaxX(self.userIconF)+5;
    self.userNameF=CGRectMake(xx, marginTop, SCREEN_WIDTH-xx-100, 30);
    self.timeF=CGRectMake(xx, marginTop+30, SCREEN_WIDTH-xx-30, 20);
   // self.thumbF=CGRectMake(SCREEN_WIDTH-50-16, marginTop+12, 16, 15);
    
    UIFont *contentfont =[UIFont systemFontOfSize:15];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:contentfont,NSFontAttributeName, nil];
    CGSize textSize= [self.model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-xx-marginLeft,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:Nil].size;
    self.contentF =CGRectMake(xx, marginTop+40+20, SCREEN_WIDTH-xx-marginLeft, textSize.height);
    
    self.cellH=CGRectGetMaxY(self.contentF)+20;
}
@end

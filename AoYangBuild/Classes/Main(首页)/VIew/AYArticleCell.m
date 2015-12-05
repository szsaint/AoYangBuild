//
//  AYArticleCell.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYArticleCell.h"
#import "AYArticleVIew.h"
@interface AYArticleCell ()
@property (nonatomic,strong) AYArticleVIew *articleView;
@end
@implementation AYArticleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        //1.创建子控件
        [self setupSubView];
//        //2.设置选中颜色
//        UIView *view=[[UIView alloc]init];
//        view.backgroundColor=RGB(20, 20, 20, 0.2);
//        self.selectedBackgroundView=view;
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView indextifier:(NSString *)indextifier
{
    AYArticleCell *cell=[tableView dequeueReusableCellWithIdentifier:indextifier];
    if(cell==nil){
        cell=[[AYArticleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indextifier];
    }
    return cell;
}

/*
 添加子控件
 */

-(void)setupSubView
{
    AYArticleVIew *articleView =[[AYArticleVIew alloc]init];
    //[self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.contentView addSubview:articleView];
    self.articleView=articleView;

}

// 数据>model>>frameModel>cell>articleView
-(void)setFrameModel:(AYArticleFrameModel *)frameModel{
    _frameModel=frameModel;
    self.articleView.frameModel=frameModel;
    
}

@end

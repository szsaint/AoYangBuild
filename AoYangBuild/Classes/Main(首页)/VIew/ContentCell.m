//
//  ContentCell.m
//  AoYangBuild
//
//  Created by wl on 15/11/9.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "ContentCell.h"
#import "contentFrameModel.h"
#import "ContentModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ContentCell ()
@property (nonatomic,strong)UIImageView *userIcon;
@property (nonatomic,strong)UILabel *userName;
@property (nonatomic,strong)UILabel *time;
@property (nonatomic,strong)UIButton *thumb;
@property (nonatomic,strong)UILabel *thumbCount;

@property (nonatomic,strong)UILabel *content;
@end

@implementation ContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    ContentCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[ContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}
-(void)setFrameModel:(contentFrameModel *)frameModel{
    _frameModel=frameModel;
    self.userName.frame =frameModel.userNameF;
    self.userName.text=frameModel.model.userName;
    
    self.userIcon.frame=frameModel.userIconF;
    self.userIcon.backgroundColor=vcColor;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:frameModel.model.userIcon] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    self.time.frame =frameModel.timeF;
    self.time.text=frameModel.model.time;
    
    self.content.frame=frameModel.contentF;
    self.content.text=frameModel.model.content;
    
    //self.thumb.frame =frameModel.thumbF;
    //self.thumb.selected=frameModel.model.thumb;
    
//    CGRect frame =self.thumb.frame;
//    //self.thumbCount.text=frameModel.model.thumbCount;
//    self.thumbCount.frame=CGRectMake(CGRectGetMaxX(frame)+3, frame.origin.y-2, 45, 20);
}
-(void)setUpSubViews{
    UIImageView *imageV =[[UIImageView alloc]init];
    [self.contentView addSubview:imageV];
    imageV.layer.cornerRadius=20;
    imageV.layer.masksToBounds=YES;
    self.userIcon=imageV;
    
    self.userName= [[UILabel alloc]init];
    self.userName.font=[UIFont systemFontOfSize:15];
    self.userName.textColor=[UIColor grayColor];
    [self.contentView addSubview:self.userName];
    
    self.time =[[UILabel alloc]init];
    self.time.font =[UIFont systemFontOfSize:12];
    self.time.textColor =[UIColor grayColor];
    [self.contentView addSubview: self.time];
    
    self.thumb =[[UIButton alloc]init];
    [self.thumb setBackgroundImage:[UIImage imageNamed:@"thumbed"] forState:UIControlStateSelected];
    [self.thumb setBackgroundImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.thumb];
    self.thumbCount=[[UILabel alloc]init];
    self.thumbCount .textColor=[UIColor grayColor];
    self.thumbCount.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.thumbCount];
    
    
    self.content =[[UILabel alloc]init];
    self.content.font =[UIFont systemFontOfSize:15];
    self.content.numberOfLines=0;
    [self.contentView addSubview:self.content];
    
    
    
}
@end

//
//  AYNotificationCell.m
//  AoYangBuild
//
//  Created by wl on 15/11/8.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYNotificationCell.h"
#import "AYAticleModel.h"

#define  magrginLeft 20

@interface AYNotificationCell ()
@property (nonatomic,strong)UILabel *title;//标题
@property (nonatomic,strong)UILabel *detailTilte;//详情
@property (nonatomic,strong)UILabel *time;//时间
@property (nonatomic,strong)UILabel *companyName;//公司名称

@end

@implementation AYNotificationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableViewTableView:(UITableView *)tabView identifier:(NSString *)identifeir{
    AYNotificationCell *cell =[tabView dequeueReusableCellWithIdentifier:identifeir];
    if (!cell) {
        cell=[[AYNotificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifeir];
        cell.contentView.backgroundColor=[UIColor whiteColor];
        cell.backgroundColor=vcColor;
//        UIView *back =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 155)];
//        back.backgroundColor=vcColor;
//        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(magrginLeft, 8, SCREEN_WIDTH-2*magrginLeft, 140)];
//        view.backgroundColor=[UIColor blackColor];
//        view.alpha=0.1;
//        view.layer.cornerRadius=6;
//        view.layer.masksToBounds=YES;
//        [back addSubview:view];
//        cell.selectedBackgroundView=back;
//        cell.highlighted=YES;
    
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews{
    UIButton *view =[[UIButton alloc]initWithFrame:CGRectMake(magrginLeft, 8, SCREEN_WIDTH-2*magrginLeft, 140)];
    
    self.title=[[UILabel alloc]initWithFrame:CGRectMake(8, 15, view.width-16, 20)];
    self.title.textColor=appColor;
    self.title.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.title];
    
    self.detailTilte =[[UILabel alloc]initWithFrame:CGRectMake(8, 40, view.width-16, 45)];
    self.detailTilte.numberOfLines=2;
    self.detailTilte.textAlignment=NSTextAlignmentCenter;
    self.detailTilte.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.detailTilte];
    
    
    self.companyName=[[UILabel alloc]initWithFrame:CGRectMake(30, 90, view.width-60, 20)];
    self.companyName.font=[UIFont systemFontOfSize:13];
    self.companyName.textAlignment=NSTextAlignmentRight;
    self.companyName.textColor=[UIColor grayColor];
    [self.contentView addSubview:self.companyName];
    
    self.time=[[UILabel alloc]initWithFrame:CGRectMake(8, 110,view.width-16, 20)];
    self.time.font=[UIFont systemFontOfSize:13];
    self.time.textColor=[UIColor grayColor];
    self.time.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.time];

    
    
}
-(void)setModel:(AYAticleModel *)model{
    _model=model;
    self.title.text=model.title;
    self.detailTilte.text=model.subtitle;
    self.time.text=model.time;
    self.companyName.text=@"澳洋集团";
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.contentView.frame=CGRectMake(magrginLeft, 8, SCREEN_WIDTH-2*magrginLeft, 140);
    self.contentView.layer.cornerRadius=6;
    self.contentView.layer.masksToBounds=YES;
    self.selectedBackgroundView.frame=self.contentView.frame;
    self.selectedBackgroundView.layer.cornerRadius=6;
    self.selectedBackgroundView.layer.masksToBounds=YES;
}
@end

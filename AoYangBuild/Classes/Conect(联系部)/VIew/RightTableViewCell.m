//
//  RightTableViewCell.m
//  AoYangBuild
//
//  Created by wl on 15/10/23.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "RightTableViewCell.h"
#import "UIImage+KW.h"

@implementation RightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView identifiter:(NSString *)identifier{
    RightTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[RightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    CGFloat marginLeft =30;
    CGFloat margintop =10;
    
    self.selectedView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.2*SCREEN_WIDTH, 110)];
    self.selectedView.backgroundColor =appColor;
    [self.contentView addSubview:self.selectedView];
    self.selectedView.hidden=YES;
    //头像
    self.icon =[[UIImageView alloc]initWithFrame:CGRectMake(marginLeft, margintop, 40, 40)];
    //self.icon.backgroundColor=[UIColor greenColor];
    //UIImage *image =[UIImage circleImageWithName:@"黑车" borderWidth:0.0 borderColor:nil];
    //self.icon.image =image;
    //self.icon.layer.masksToBounds=YES;
    //self.icon.contentMode =UIViewContentModeScaleAspectFit;
    self.icon.image =[UIImage imageNamed:@"icon"];
    self.icon.layer.cornerRadius=20;
    self.icon.layer.masksToBounds=YES;
    [self.contentView addSubview:self.icon];
    
    //名字
    CGFloat iconMaxX =CGRectGetMaxX(self.icon.frame);
    self.name=[[UILabel alloc]initWithFrame:CGRectMake(iconMaxX+5, margintop, self.width-iconMaxX-10, 25)];
    self.name.font=[UIFont systemFontOfSize:15];
    //[self.contentView addSubview:self.name];
    
    //职位
    self.position =[[UILabel alloc]initWithFrame:CGRectMake(iconMaxX+5, margintop, self.name.width, 40)];
    self.position.font=[UIFont systemFontOfSize:15];
    self.position.textColor=appColor;
    [self.contentView addSubview:self.position];
    
    //手机号码
    //CGFloat YY =CGRectGetMaxY(self.icon.frame);
    self.phoneNumber =[[UILabel alloc]initWithFrame:CGRectMake(marginLeft, 50, self.width, 40)];
    self.phoneNumber.font=[UIFont systemFontOfSize:14];
    self.phoneNumber.textColor=[UIColor lightGrayColor];
    [self.contentView addSubview:self.phoneNumber];
    self.name.text=@"昵称";

    //[self makeTestData];
}
-(void)makeTestData{
    self.position.text=@"职位: 销售经理";
    self.phoneNumber.text=@"电话号码: 12345678910";
}
@end

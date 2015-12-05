//
//  AYSearchViewCell.m
//  AoYangBuild
//
//  Created by wl on 15/10/22.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYSearchViewCell.h"

@implementation AYSearchViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID =@"search_cell";
    AYSearchViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[AYSearchViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //cell.separatorInset =UIEdgeInsetsMake(1, 0, 0, 0);
    }
    return cell;
}
-(void)setUp{
    //移除子控件
    //[self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat mariginLeft=20;
    CGFloat margintop=16;
    //添加imageView
    UIButton *selectBtn =[[UIButton alloc]initWithFrame:CGRectMake(mariginLeft, margintop, 18, 18)];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"Uncheck button 2"] forState:UIControlStateNormal];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"Select the button 2"] forState:UIControlStateSelected];
    selectBtn.userInteractionEnabled=NO;
    self.selectBtn=selectBtn;
    [self.contentView addSubview:selectBtn];
    
    //添加 标题lable
    UILabel *businessName =[[UILabel alloc]initWithFrame:CGRectMake(mariginLeft+18+20, 0, SCREEN_WIDTH-mariginLeft-18-20, 50)];
    businessName.font=[UIFont systemFontOfSize:14];
    self.businessName=businessName;
    [self.contentView addSubview:businessName];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (self.selectBtn.selected) {
//        self.selectBtn.selected=!self.selectBtn.selected;
//    }
}
@end

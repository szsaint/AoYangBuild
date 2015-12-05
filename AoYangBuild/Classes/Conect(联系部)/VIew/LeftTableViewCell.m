//
//  LeftTableViewCell.m
//  AoYangBuild
//
//  Created by wl on 15/10/23.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "LeftTableViewCell.h"
@interface LeftTableViewCell ()
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,strong)UIView *cover;

@end

@implementation LeftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    LeftTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell =[[LeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    CGFloat tableWW =0.256*SCREEN_WIDTH;
//    //背景
//    UIView *cover =[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableWW, 50)];
//    cover.backgroundColor=RGB(53, 131, 203, 1);
//    [self.contentView addSubview:cover];
//    self.cover=cover;
//    //self.cover.hidden=YES;

    //部门名称
    self.positonBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, tableWW, 50)];
    [self.positonBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.positonBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.positonBtn setBackgroundImage:[self createImageWithColor:RGB(53, 131, 203, 1)] forState:UIControlStateSelected];
    self.positonBtn.userInteractionEnabled=NO;
    self.positonBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.positonBtn];
    
    //选中背景图
    UIView *back =[[UIView alloc]init];
    //back.backgroundColor=RGB(53, 131, 203, 1);
    back.backgroundColor=[UIColor clearColor];
    self.selectedBackgroundView=back;
    
    //right Line
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(tableWW-1, 0, 0.5, 50)];
    line.backgroundColor=[UIColor lightGrayColor];
    [self.contentView addSubview:line];
    
    //三角箭头16*23
    UIImageView *arrow =[[UIImageView alloc]initWithFrame:CGRectMake(tableWW-9.5, (50-14)/2.0f, 10, 14)];
    arrow.image =[UIImage imageNamed:@"sanjiao"];
    self.arrow=arrow;
    self.arrow.hidden=YES;
    [self.contentView addSubview:arrow];
    
}

//选中状态
-(void)selectedStatus{
    self.positonBtn.selected=YES;
    self.arrow.hidden=NO;
   // self.cover.hidden=NO;
}

//取消选中
-(void)desSelectedStatus{
    self.positonBtn.selected=NO;
    self.arrow.hidden=YES;
   // self.cover.hidden=YES;
}



-(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}










@end

//
//  AYMeCell.m
//  AoYangBuild
//
//  Created by wl on 15/11/7.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYMeCell.h"
@interface AYMeCell ()
@property(nonatomic,strong)UILabel *myTitle;
@property(nonatomic,strong)UILabel *myDetailLable;
@end


@implementation AYMeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    AYMeCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell =[[AYMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifie]) {
        [self setUpSubViews];
    }
    
    return self;
}
-(void)setUpSubViews{
    
}
-(void)setImageName:(NSString *)imageName{
    _imageName =imageName;
    UIImage *image =[UIImage imageNamed:imageName];
    CGSize imaS =image.size;
    self.imageView.width=imaS.width;
    self.imageView.height=imaS.height;
    self.imageView.center=CGPointMake(20, self.height/2);
    self.imageView.image=image;
    
}
-(void)setTitle:(NSString *)title{
    _title =title;
    //    self.textLabel.text=title;
    //    self.textLabel.textColor=CONTENT_COLOR;
    //    self.textLabel.x=100;
    //体统的textLabel 和detailTitle都是readOnly  所以改变不了
    self.myTitle.text=title;
}
-(void)setDetailTitle:(NSString *)detailTitle{
    _detailTitle =detailTitle;
    //    self.detailTextLabel.backgroundColor=[UIColor redColor];//text=detailTitle;
    self.myDetailLable.text=detailTitle;
    
}
-(UILabel *)myTitle{
    if (!_myTitle) {
        _myTitle =[[UILabel alloc]initWithFrame:CGRectMake(60, 0, SCREEN_WIDTH-60, 60)];
        _myTitle.font=[UIFont systemFontOfSize:16];
        [self.contentView addSubview:_myTitle];
    }
    return _myTitle;
}
-(UILabel *)myDetailLable{
    if (!_myDetailLable) {
        CGFloat mar =SCREEN_WIDTH/375*35;
        _myDetailLable = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2-mar, 60)];
        _myDetailLable.textColor=[UIColor grayColor];
        _myDetailLable.font=[UIFont systemFontOfSize:15];
        _myDetailLable.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:_myDetailLable];
    }
    return _myDetailLable;
}

@end

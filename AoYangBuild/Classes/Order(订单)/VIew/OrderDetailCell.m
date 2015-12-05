//
//  OrderDetailCell.m
//  AoYangBuild
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "OrderDetailCell.h"
#import "OrderSpeedModel.h"
#define marginLeft 10
#define marginTop 12


@implementation OrderDetailCell
-(void)setModel:(OrderSpeedModel *)model{
    _model=model;
    self.title.text=model.title;
    self.time.text=model.time;
    self.detailTitle.text=model.detailTitle;
    self.price.text=[NSString stringWithFormat:@"￥%@",model.price];
    self.needPay.text=@"待缴";
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//120
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    OrderDetailCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[[OrderDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [self.contentView addSubview:self.time];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.detailTitle];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self.needPay];


}

-(UILabel *)title{
    if (!_title) {
        _title =[[UILabel alloc]initWithFrame:CGRectMake(marginLeft, marginTop, SCREEN_WIDTH-100, 38)];
        _title.font=[UIFont systemFontOfSize:17];
    }
    return _title;
}

-(UILabel *)time{
    if (!_time) {
        _time =[[UILabel alloc]initWithFrame:CGRectMake(marginLeft, marginTop+38, SCREEN_WIDTH/2, 20)];
        _time.font=[UIFont systemFontOfSize:13];
        _time.textColor=[UIColor grayColor];
    }
    return _time;
}

-(UILabel *)detailTitle{
    if (!_detailTitle) {
        _detailTitle =[[UILabel alloc]initWithFrame:CGRectMake(marginLeft, marginTop+38+20, SCREEN_WIDTH-2*marginLeft, 35)];
        _detailTitle.font=[UIFont systemFontOfSize:15];
    }
    return _detailTitle;
}
-(UILabel *)price{
    if (!_price) {
        _price =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 25, SCREEN_WIDTH/2-marginLeft, 40)];
        _price.textColor=[UIColor redColor];
        _price.font=[UIFont systemFontOfSize:18];
        _price.textAlignment=NSTextAlignmentRight;
    }
    return _price;
}
-(UILabel *)needPay{
    if (!_needPay) {
        _needPay =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60-marginLeft, 0, 60, 25)];
        _needPay.textColor=[UIColor redColor];
        _needPay.textAlignment=NSTextAlignmentRight;
    }
    return _needPay;
}
@end

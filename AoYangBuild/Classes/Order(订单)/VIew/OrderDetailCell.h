//
//  OrderDetailCell.h
//  AoYangBuild
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderSpeedModel;

@interface OrderDetailCell : UITableViewCell
@property (nonatomic,strong)UILabel *title;//标题
@property (nonatomic,strong)UILabel *time;//时间
@property (nonatomic,strong)UILabel *detailTitle;//子标题
@property (nonatomic,strong)UILabel *price;//价钱

@property (nonatomic,strong)UILabel *needPay;//需要缴费


@property (nonatomic,strong)OrderSpeedModel *model;

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
@end


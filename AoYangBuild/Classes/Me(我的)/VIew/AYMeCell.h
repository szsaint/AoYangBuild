//
//  AYMeCell.h
//  AoYangBuild
//
//  Created by wl on 15/11/7.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AYMeCell : UITableViewCell
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *detailTitle;
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

@end

//
//  RightTableViewCell.h
//  AoYangBuild
//
//  Created by wl on 15/10/23.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *position;
@property(nonatomic,strong)UILabel *phoneNumber;
+(instancetype)cellWithTableView:(UITableView *)tableView identifiter:(NSString *)identifier;
@end

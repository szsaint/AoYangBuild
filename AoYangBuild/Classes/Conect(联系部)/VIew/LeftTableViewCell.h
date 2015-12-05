//
//  LeftTableViewCell.h
//  AoYangBuild
//
//  Created by wl on 15/10/23.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *positonBtn;

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
-(void)selectedStatus;
-(void)desSelectedStatus;
@end

//
//  AYSearchViewCell.h
//  AoYangBuild
//
//  Created by wl on 15/10/22.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AYSearchViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *selectBtn;
@property(nonatomic,strong)UILabel *businessName;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end

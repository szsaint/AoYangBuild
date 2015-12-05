//
//  AYNotificationCell.h
//  AoYangBuild
//
//  Created by wl on 15/11/8.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AYAticleModel;

@interface AYNotificationCell : UITableViewCell

@property (nonatomic,strong)AYAticleModel *model;

+(instancetype)cellWithTableViewTableView:(UITableView *)tabView identifier:(NSString *)identifeir;
@end

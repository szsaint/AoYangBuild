//
//  ContentCell.h
//  AoYangBuild
//
//  Created by wl on 15/11/9.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class contentFrameModel;

@interface ContentCell : UITableViewCell

@property (nonatomic,strong)contentFrameModel *frameModel;

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
@end

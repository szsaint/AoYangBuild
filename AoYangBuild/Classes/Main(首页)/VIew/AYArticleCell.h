//
//  AYArticleCell.h
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AYArticleFrameModel.h"

@interface AYArticleCell : UITableViewCell

@property(nonatomic,strong)AYArticleFrameModel *frameModel;
+(instancetype)cellWithTableView:(UITableView*)tableView indextifier:(NSString*)indextifier;


@end

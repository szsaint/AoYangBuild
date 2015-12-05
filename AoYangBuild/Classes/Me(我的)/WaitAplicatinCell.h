//
//  WaitAplicatinCell.h
//  AoYangBuild
//
//  Created by wl on 15/11/30.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaitAplicatinCell;
@protocol WaitAplicatinCellDelegate <NSObject>

-(void)WaitAplicatinCell:(WaitAplicatinCell *)cell acceptBtnOnClick:(UIButton *)sender;

@end

@interface WaitAplicatinCell : UITableViewCell
@property (nonatomic,assign)NSInteger state;
@property (nonatomic,weak)id<WaitAplicatinCellDelegate>delegate;
+(instancetype)waitAplicatinCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
@end

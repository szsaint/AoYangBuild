//
//  OrderDetailToDController.h
//  AoYangBuild
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, OrderDetailToDControllerType) {
    OrderDetailToDControllerTypeWaitPay =0,        // regular table view
    OrderDetailToDControllerTypeHadPay         // preferences style table view
};
@class OrderSpeedModel;
@interface OrderDetailToDController : UIViewController
@property (nonatomic,assign)OrderDetailToDControllerType type;
@property (nonatomic,strong)OrderSpeedModel *model;

@end

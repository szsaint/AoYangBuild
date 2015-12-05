//
//  RegistController.h
//  AoYangBuild
//
//  Created by wl on 15/10/19.
//  Copyright © 2015年 saint. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,RegisterType){
    RegisterTypeSub=0,//个人注册
    RegisterTypeCompany,//企业注册
};

@interface RegistController : UIViewController

@property (nonatomic,assign)RegisterType type;

@end

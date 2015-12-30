//
//  AYBaseVC.m
//  AoYangBuild
//
//  Created by wl on 15/12/29.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYBaseVC.h"
#import "BaseNoDataView.h"

@interface AYBaseVC ()

@end

@implementation AYBaseVC{
    BaseNoDataView *viewEmpty;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    viewEmpty =[[BaseNoDataView alloc]initWithFrame:self.view.bounds];
}

-(void)showEmpty{
    viewEmpty.frame =self.view.bounds;
    [self.view addSubview:viewEmpty];
}
-(void)showEmpty:(CGRect)frame{
    viewEmpty.frame =frame;
    [self.view addSubview:viewEmpty];
}
@end

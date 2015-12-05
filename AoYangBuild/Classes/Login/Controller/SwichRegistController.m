//
//  SwichRegistController.m
//  AoYangBuild
//
//  Created by wl on 15/10/19.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "SwichRegistController.h"
#import "RegistController.h"

@interface SwichRegistController ()

@end

@implementation SwichRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self setUI];
}

-(void)setUI{
    UIView *back =[[UIView alloc]init];
    back.backgroundColor=[UIColor clearColor];
    [self.view addSubview:back];
    
    //businessBtn
    UIButton *business =[[UIButton alloc]initWithFrame:CGRectMake(35, 0, SCREEN_WIDTH-70, 50)];
    business.backgroundColor=[UIColor clearColor];
    [business setImage:[UIImage imageNamed:@"Enterprise registration selected button"] forState:UIControlStateNormal];
    business.tag=101;
    [business addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:business];
    
    //personalBtn
    UIButton *personal =[[UIButton alloc]initWithFrame:CGRectMake(35, 90, SCREEN_WIDTH-70, 50)];
    personal.backgroundColor=[UIColor clearColor];
    [personal setImage:[UIImage imageNamed:@"Individual registration selected button"] forState:UIControlStateNormal];
    personal.tag=102;
    [personal addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:personal];
    
    //loginBtn
    UIButton *login =[[UIButton alloc]initWithFrame:CGRectMake(35, 180-8, SCREEN_WIDTH-70, 50)];
    login.backgroundColor=[UIColor clearColor];
    [login setImage:[UIImage imageNamed:@"The login selected button 2"] forState:UIControlStateNormal];
    login.tag=103;
    [login addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:login];
    CGFloat yy=CGRectGetMaxY(login.frame)+30;
    back.frame=CGRectMake(0, 0, SCREEN_WIDTH, yy);
    back.center=self.view.center;
    
    //cancelBtn
    UIButton *cancel =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20-25, 30, 25, 25)];
    [cancel setBackgroundImage:[UIImage imageNamed:@"Exit button"] forState:UIControlStateNormal];
    cancel.tag=104;
    [cancel addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];
    
}
-(void)btnOnClick:(UIButton*)sender{
  
    switch (sender.tag) {
        case 101:
            //business
            [self presentVC:RegisterTypeCompany];
            break;
        case 102:
            //personal
            [self presentVC:RegisterTypeSub];
            break;
        case 103:
            //login
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
        case 104:
            //cancel
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];

            break;
    }
    NSLog(@"%ld",(long)sender.tag);
}
-(void)presentVC:(RegisterType)type{
    RegistController *registVC =[[RegistController alloc]init];
    registVC.type=type;
    [self presentViewController:registVC animated:YES completion:nil];
    
}
@end

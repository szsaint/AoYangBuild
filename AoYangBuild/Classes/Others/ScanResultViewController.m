//
//  ScanResultViewController.m
//  AoYangBuild
//
//  Created by wl on 15/12/16.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "ScanResultViewController.h"
#import "GuardSearchApi.h"
#import <MBProgressHUD.h>
#import "UserInfoModel.h"
@interface ScanResultViewController ()
@property (nonatomic,strong)UILabel *nothingLab;

@end

@implementation ScanResultViewController{
    NSString *_Uid;
}
-(instancetype)initWithUid:(NSString *)Uid{
    if (self =[super init]) {
        _Uid =Uid;
    }
    return self;
}
-(UILabel *)nothingLab{
    if (!_nothingLab) {
        _nothingLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _nothingLab.text =@"暂无该人员信息";
        _nothingLab.textAlignment =NSTextAlignmentCenter;
        _nothingLab.textColor =[UIColor lightGrayColor];
        [self.view addSubview:_nothingLab];
        _nothingLab.center =self.view.center;
        _nothingLab.hidden =YES;
    }
    return _nothingLab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =vcColor;
    self.title =@"搜索结果";
    UIButton *left =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 14, 24)];
    [left setImage:[UIImage imageNamed:@"chevron left"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:left];
    if (![_Uid hasPrefix:@"澳洋集团的二维码"]) {
        self.nothingLab.hidden=NO;
    }else{
        NSString *str =[_Uid substringFromIndex:9];
        [self loadData:str];
    }
}
-(void)leftBtnOnClick:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)loadData:(NSString *)str{
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText =@"加载中...";
    GuardSearchApi *api =[[GuardSearchApi alloc]initWithUid:str];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id result  = [request responseJSONObject];
        if ([result isKindOfClass:[NSDictionary class]]){
            UserInfoModel *model =[UserInfoModel UserInfoWithDic:result];
            [self creatViewWithModel:model];
        }
        [hud hide:YES];
    } failure:^(YTKBaseRequest *request) {
        [hud hide:YES];
        self.nothingLab.hidden=NO;
    }];
}
-(void)creatViewWithModel:(UserInfoModel *)model{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    //view.backgroundColor=appColor;//56  123  230
    
    UIImageView *user =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80 , 80)];
    user.layer.cornerRadius=user.width/2;
    user.layer.masksToBounds=YES;
    user.userInteractionEnabled=YES;
    user.image =[UIImage imageNamed:@"icon"];
    
    [view addSubview:user];
    user.center=CGPointMake(60, view.center.y-20);
    
    //用户名
    UILabel *userName=[[UILabel alloc]initWithFrame:CGRectMake(20, 130, SCREEN_WIDTH-40, 25)];
    userName.textAlignment=NSTextAlignmentLeft;
    userName.font=[UIFont systemFontOfSize:15];
    userName.text=model.display_name;
    [view addSubview:userName];
    
    
    //名称
    UILabel *companyName =[[UILabel alloc]initWithFrame:CGRectMake(20, 170,  SCREEN_WIDTH-40, 25)];
    companyName.textAlignment=NSTextAlignmentLeft;
    companyName.font=[UIFont systemFontOfSize:15];
    companyName.text =model.user_company.name;
    [view addSubview:companyName];
    
    //电话
    UILabel *mobile=[[UILabel alloc]initWithFrame:CGRectMake(20, 205, SCREEN_WIDTH-40, 25)];
    mobile.textAlignment=NSTextAlignmentLeft;
    mobile.font=[UIFont systemFontOfSize:15];
    mobile.textColor=[UIColor lightGrayColor];
    if (model.mobile.length>0) {
        mobile.text=[NSString stringWithFormat:@"联系电话：%@",model.mobile];
    }else{
        mobile.text=@"联系电话：未设置";
    }
    [view addSubview:mobile];

    //公司电话
    UILabel *comPhone =[[UILabel alloc]initWithFrame:CGRectMake(20, 245,  SCREEN_WIDTH/2-40, 25)];
    comPhone.textAlignment=NSTextAlignmentLeft;
    comPhone.font=[UIFont systemFontOfSize:15];
    comPhone.textColor=[UIColor lightGrayColor];
    if (model.user_company.phone.length>0) {
        comPhone.text=[NSString stringWithFormat:@"公司电话：%@",model.user_company.phone];
    }else{
        comPhone.text=@"公司电话：未设置";
    }

    [view addSubview:comPhone];
    [self.view addSubview:view];
    
}

@end

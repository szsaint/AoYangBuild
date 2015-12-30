//
//  ConectController.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "ConectController.h"
#import "AYSearchController.h"

#import "LeftTableViewCell.h"
#import "RightTableViewCell.h"
#import "SearchCompanyApi.h"
#import "ConectModel.h"
#import <AFNetworking.h>
#import "UserManeger.h"
#import "TitleView.h"

#import "SubLBXScanViewController.h"
#import "MyQRViewController.h"
#import "LBXScanView.h"
#import <objc/message.h>
//#import "ScanResultViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"


@interface ConectController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)NSArray *leftArray;
@property(nonatomic,strong)NSIndexPath *leftCurentIndexPath;
@property(nonatomic,strong)UITableView *righttableView;
@property(nonatomic,strong)NSArray *rightArray;
@property(nonatomic,strong)TitleView *titleView;

@end

@implementation ConectController{
    BOOL isFresh;
    BOOL isBegin;
}

-(instancetype)init{
    if (self=[super init]) {
        self.title=@"通讯录";
        self.tabBarItem.image=[UIImage imageNamed:@"Contact Icon（not Selected）"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    self.leftCurentIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self setUI];
    [self loadData];
}
-(void)loadData{
    NSString *companyID =[[NSUserDefaults standardUserDefaults]objectForKey:@"companyID"];
    SearchCompanyApi *api =[[SearchCompanyApi alloc]initWithCompany:companyID];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id reslut =[request responseJSONObject];
        NSDictionary *usersDic =[reslut valueForKey:@"users"];
        NSMutableArray *arrM =[NSMutableArray array];
        for (NSString *key  in usersDic.allKeys) {
            NSDictionary *oneDic =usersDic[key];
            ConectModel *model =[[ConectModel alloc]init];
            model.name =oneDic[@"display_name"];
            //model.phone=oneDic[@"user_login"];
            NSString *phone =oneDic[@"mobile"];
            if (phone.length>0) {
                model.phone=phone;
            }else{
                model.phone=@"未设置";
            }
            [arrM addObject:model];
        }
        self.rightArray =arrM;
        [self.titleView.animateView stopAnimating];
        isFresh =NO;
        [self.righttableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        id reslut =[request responseJSONObject];
        NSLog(@"%@",reslut);
        [self.titleView.animateView stopAnimating];
        isFresh =NO;

    }];
}
-(void)setUI{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(roleChange) name:@"roleChange" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(roleChange) name:@"guard" object:nil];
    TitleView *titleView =[[TitleView alloc]initWithTitle:@"通讯录"];
    self.navigationItem.titleView =titleView;
    self.titleView=titleView;
    
    self.righttableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    self.righttableView.backgroundColor=[UIColor whiteColor];
    self.righttableView.delegate=self;
    self.righttableView.dataSource=self;
    self.righttableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:self.righttableView];
    
    [self roleChange];
  
}
-(void)roleChange{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"company"]) {
        UIButton *left =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [left setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(leftBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:left];
    }else if ([[NSUserDefaults standardUserDefaults]objectForKey:@"guard"]) {
        UIButton *right =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [right setImage:[UIImage imageNamed:@"saomiao"] forState:UIControlStateNormal];
        [right addTarget:self action:@selector(rightBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:right];
        
        UIButton *left =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [left setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(leftBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:left];

    }else{
        self.navigationItem.rightBarButtonItem =nil;
        self.navigationItem.leftBarButtonItem =nil;
    }

    
}
-(void)rightBtnOnClick:(UIButton *)sender{
    [self ZhiFuBaoStyle];
}
-(void)leftBtnOnClick:(UIButton *)sender{
    AYSearchController *searchVC =[[AYSearchController alloc]init];
    searchVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}
#pragma mark  ----two  tableView  delegate  dataSource------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.leftTableView) {
        static NSString *leftID =@"left_cell";
        LeftTableViewCell *leftcell =[LeftTableViewCell cellWithTableView:tableView identifier:leftID];
        NSArray *array =@[@"董事会",@"财务部",@"人事部",@"运营部",@"技术部",@"董事会",@"财务部",@"人事部",@"运营部",@"技术部",@"董事会",@"财务部",@"人事部",@"运营部",@"技术部"];
        [leftcell.positonBtn setTitle:array[indexPath.row] forState:UIControlStateNormal];
        if (self.leftCurentIndexPath&&self.leftCurentIndexPath.row==indexPath.row) {
            [leftcell selectedStatus];
        }else{
            [leftcell desSelectedStatus];
        }
        return leftcell;
    }else if (tableView==self.righttableView){
        static NSString *rightID =@"right_cell";
        RightTableViewCell *rightcell =[RightTableViewCell cellWithTableView:tableView identifiter:rightID];
        //cell  赋值
        ConectModel *model =self.rightArray[indexPath.row];
        rightcell.position.text =model.name;
        rightcell.phoneNumber.text =[NSString stringWithFormat:@"联系电话：%@",model.phone];
        return rightcell;
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.leftTableView) {
        //return _leftArray.count;
        return 15;
    }else if (tableView==self.righttableView){
        return self.rightArray.count;
    }
    return 0;
}
//tableView  选中 与取消选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.leftTableView) {
        if (indexPath.row!=0&&self.leftCurentIndexPath.row==0) {
            LeftTableViewCell *first_cell =[tableView cellForRowAtIndexPath:self.leftCurentIndexPath];
            [first_cell desSelectedStatus];
        }
        LeftTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        [cell selectedStatus];
        self.leftCurentIndexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
        [self.righttableView reloadData];
    }else if (tableView==self.righttableView){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        ConectModel *model =self.rightArray[indexPath.row];
        UIWebView *web =[[UIWebView alloc]init];
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.phone]]]];
        [self.view addSubview:web];

    }

}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.leftTableView) {
        LeftTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
        [cell desSelectedStatus];
    }else if(tableView==self.righttableView){
    
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.leftTableView) {
        return 50;
    }else if (tableView==self.righttableView){
        return 90;
    }
    return 0;
}
-(void)login{
    [self.titleView.animateView startAnimating];
    NSString *base64LoginString =[[NSUserDefaults standardUserDefaults]objectForKey:@"basekey"];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    //[manager.requestSerializer setValue:(NSString *)base64LoginString forHTTPHeaderField:@"Authorization"];
    AFHTTPRequestOperation *opration = [manager GET:@"http://112.80.40.185/wp-json/users/me" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        id result =responseObject;
        NSLog(@"%@",result);
        [self.titleView.animateView stopAnimating];
        //保存用户信息
        [UserManeger saveUserLoginInfo:result baseKey:base64LoginString];
        [self loadData];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"creatSuccess" object:nil];

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [self.titleView.animateView stopAnimating];
        isFresh =NO;
        id result =operation.responseObject;
        NSLog(@"%@",result);
        
        
    }];
    
    
    [opration setRedirectResponseBlock:^NSURLRequest * _Nonnull(NSURLConnection * _Nonnull connection, NSURLRequest * _Nonnull request, NSURLResponse * _Nonnull redirectResponse) {
        
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        NSString *value =base64LoginString;
        [mutableRequest addValue:value forHTTPHeaderField:@"Authorization"];
        request =[mutableRequest copy];
        return request;
    }];
    
    
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.righttableView) {
        CGFloat offy =scrollView.contentOffset.y;
        if (!isBegin&&offy<-50&&!isFresh) {
            isFresh=YES;
            isBegin =YES;
            [self animatRefresh];
        }
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (isBegin) {
        isBegin=NO;
    }
}
-(void)animatRefresh{
    [self.titleView.animateView startAnimating];
    [self login];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"roleChange" object:nil];
}

#pragma mark --模仿支付宝
- (void)ZhiFuBaoStyle
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480 )
    {
        //3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    
    
    style.alpa_notRecoginitonArea = 0.6;
    
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    
    
    style.animationImage = imgFullNet;
    
    
    [self openScanVCWithStyle:style];
}
- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;
    //vc.isOpenInterestRect = YES;
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

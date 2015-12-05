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
#import <MBProgressHUD.h>
#import <AFNetworking.h>
#import "UserManeger.h"
@interface ConectController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)NSArray *leftArray;
@property(nonatomic,strong)NSIndexPath *leftCurentIndexPath;





@property(nonatomic,strong)UITableView *righttableView;
@property(nonatomic,strong)NSArray *rightArray;

@end

@implementation ConectController

-(instancetype)init{
    if (self=[super init]) {
        self.title=@"联系部";
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.righttableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        id reslut =[request responseJSONObject];
        NSLog(@"%@",reslut);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
}
-(void)setUI{
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    //搭建leftTableView  rightTableView
    //279  0.744
//    CGFloat rightWW =SCREEN_WIDTH*0.744;
//    CGFloat leftWW =SCREEN_WIDTH-rightWW;
//    self.leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, leftWW, SCREEN_HEIGHT-49-64)];
//    self.leftTableView.showsVerticalScrollIndicator=NO;
//    self.leftTableView.backgroundColor=[UIColor lightTextColor];
//    self.leftTableView.dataSource=self;
//    self.leftTableView.delegate=self;
//    self.leftTableView.tableFooterView=[[UIView alloc]init];
//    //self.leftTableView.bounces=NO;
//    [self.view addSubview:self.leftTableView];
    
    self.righttableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    self.righttableView.backgroundColor=[UIColor whiteColor];
    self.righttableView.delegate=self;
    self.righttableView.dataSource=self;
    self.righttableView.tableFooterView=[[UIView alloc]init];
    [self.view addSubview:self.righttableView];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"company"]) {
        UIButton *left =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
        [left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [left setTitle:@"其他" forState:UIControlStateNormal];
        [left addTarget:self action:@selector(leftBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:left];
    }
}
-(void)rightBtnOnClick:(UIButton *)sender{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"companyID"]) {
        [self loadData];
    }else{
        [self login];
    }
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
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *base64LoginString =[[NSUserDefaults standardUserDefaults]objectForKey:@"basekey"];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    //[manager.requestSerializer setValue:(NSString *)base64LoginString forHTTPHeaderField:@"Authorization"];
    AFHTTPRequestOperation *opration = [manager GET:@"http://112.80.40.185/wp-json/users/me" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        id result =responseObject;
        NSLog(@"%@",result);
        [hud hide:YES];
        
        //保存用户信息
        [UserManeger saveUserLoginInfo:result baseKey:base64LoginString];
        [self loadData];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"creatSuccess" object:nil];

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [hud hide:YES];
        id result =operation.responseObject;
        NSLog(@"%@",result);
        [hud hide:YES];
        
        
    }];
    
    
    [opration setRedirectResponseBlock:^NSURLRequest * _Nonnull(NSURLConnection * _Nonnull connection, NSURLRequest * _Nonnull request, NSURLResponse * _Nonnull redirectResponse) {
        
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        NSString *value =base64LoginString;
        [mutableRequest addValue:value forHTTPHeaderField:@"Authorization"];
        request =[mutableRequest copy];
        return request;
    }];
    
    
    
    
    
}


@end

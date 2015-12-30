//
//  AYSearchController.m
//  AoYangBuild
//
//  Created by wl on 15/10/22.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYSearchController.h"
#import "RightTableViewCell.h"
#import "ConectModel.h"
#import <MBProgressHUD.h>
#import "SearchCompanyApi.h"
#import "ConectModel.h"
#import <MJRefresh.h>

//#import "AYSearchViewCell.h"

@interface AYSearchController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;//当前空前视图

@property(nonatomic,strong)NSArray *resultArray;//所有公司名称
@property(nonatomic,strong)NSArray *comapnyIDArray;

@property(nonatomic,strong)UIScrollView *backScrollView;


@property (nonatomic,strong)UITableView *detaiTableView;//详情

@property (nonatomic,strong)UIView *cover;

@property (nonatomic,strong)RightTableViewCell *cell;
@end

@implementation AYSearchController{
    NSArray *_rightArray;
}
-(UIView *)cover{
    if (!_cover) {
        _cover =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _cover.backgroundColor =[UIColor blackColor];
        _cover.alpha =0.0;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverOnClick:)];
        [_cover addGestureRecognizer:tap];
    }
    return _cover;
}
-(void)coverOnClick:(UITapGestureRecognizer *)sender{
    [UIView animateWithDuration:0.4 animations:^{
        self.detaiTableView.transform =CGAffineTransformIdentity;
        self.cell.selectedView.hidden=YES;
    }];
    [self coverHidden];
}
-(void)coverShow{
    self.cover.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.alpha=0.3;
    }];
}
-(void)coverHidden{
    [UIView animateWithDuration:0.4 animations:^{
        self.cover.alpha=0.0;
    } completion:^(BOOL finished) {
        self.cover.hidden=YES;
        self.detaiTableView.delegate=nil;
        self.detaiTableView.dataSource=nil;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setUI];
   
}


-(void)setUI{
    self.title=@"所有公司";
    //backScroll
    UIScrollView *backScrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH+SCREEN_WIDTH*0.8, SCREEN_HEIGHT-64)];
    backScrollView.showsHorizontalScrollIndicator=NO;
    backScrollView.showsVerticalScrollIndicator=NO;
    backScrollView.scrollEnabled=NO;
    self.backScrollView =backScrollView;
    [self.view addSubview:backScrollView];
    
    //tableView
    UITableView *tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableView.delegate=self;
    tableView.dataSource=self;
    self.tableView=tableView;
    self.tableView.tableFooterView =[[UIView alloc]init];
    [self.backScrollView addSubview:self.tableView];
    [self loadDate];
    
    //cover
    [self.backScrollView addSubview:self.cover];
    self.cover.hidden=YES;

    //detailTabelView
    UITableView *detailTableView =[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT-64)];
    detailTableView.showsVerticalScrollIndicator =NO;
    detailTableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadCurrentComapnyMenbers];
    }];
    detailTableView.tableFooterView =[[UIView alloc]init];
    self.detaiTableView=detailTableView;
    [self.backScrollView addSubview:detailTableView];
    
   
}
-(void)loadDate{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    SearchCompanyApi *api =[[SearchCompanyApi alloc]initWithCompany:nil];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        if ([result isKindOfClass:[NSArray class]]) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            return ;
        }
        NSDictionary *resultDic =result;
        NSMutableArray *arrM_ID =[NSMutableArray array];
        NSMutableArray *arrM =[NSMutableArray array];
        for (NSString *s in [resultDic allKeys]) {
            NSDictionary *realDic =[resultDic valueForKey:s];
            NSString *ID =realDic[@"id"];
            NSString *companyname =[realDic valueForKey:@"name"];
            ConectModel *model = [[ConectModel alloc]init];
            model.name =companyname;
            if (realDic[@"phone"]!=[NSNull null]) {
                NSString *phone =realDic[@"phone"];
                if (phone.length>0) {
                    model.phone=phone;
                }else{
                    model.phone =@"未设置";
                }
            }else{
                model.phone =@"未设置";
            }
           
//            NSArray *managerArr =realDic[@"manager"];
//            if (managerArr.count==0) {
//                model.phone =@"未设置";
//            }else{
//            NSDictionary *managerDic =managerArr[0];
//            NSString *phone =managerDic[@"mobile"];
//                if (phone.length>0) {
//                    model.phone=phone;
//                }else{
//                    model.phone =@"未设置";
//                }
//            }
            [arrM addObject:model];
            [arrM_ID addObject:ID];
        }
        self.resultArray =arrM;
        self.comapnyIDArray =arrM_ID;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark   ----tableView  delegate------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.tableView) {
        return  self.resultArray.count;
    }else if (tableView==self.detaiTableView){
        return _rightArray.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==self.tableView) {
        RightTableViewCell *cell =[RightTableViewCell cellWithTableView:tableView identifiter:@"cell"];
        ConectModel *model =self.resultArray[indexPath.row];
        cell.position.text=model.name;
        cell.phoneNumber.text =[NSString stringWithFormat:@"公司电话：%@",model.phone];
        cell.icon.image =[UIImage imageNamed:@"company"];
        cell.tag=indexPath.row;
        return cell;
    }else if (tableView==self.detaiTableView){
        RightTableViewCell *cell =[RightTableViewCell cellWithTableView:tableView identifiter:@"detail"];
        ConectModel *model =_rightArray[indexPath.row];
        cell.position.text=model.name;
        cell.phoneNumber.text =[NSString stringWithFormat:@"联系电话：%@",model.phone];
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
//        RightTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
//        self.cell =cell;
//        [self showRightTableView];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        ConectModel *model =self.resultArray[indexPath.row];
        if (model.phone.length>0) {
            UIWebView *web =[[UIWebView alloc]init];
            [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.phone]]]];
            [self.view addSubview:web];
        }else{
            return;
        }
        
    }
}
-(void)showRightTableView{
    
    [UIView animateWithDuration:0.4 animations:^{
        self.detaiTableView.transform =CGAffineTransformMakeTranslation(-0.8*SCREEN_WIDTH, 0);
    }completion:^(BOOL finished) {
        [self coverShow];
        self.cell.selectedView.hidden=NO;
        [self.detaiTableView.header beginRefreshing];
    }];
}

-(void)loadCurrentComapnyMenbers{
    SearchCompanyApi *api =[[SearchCompanyApi alloc]initWithCompany:self.comapnyIDArray[self.cell.tag]];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id reslut =[request responseJSONObject];
        NSDictionary *usersDic =[reslut valueForKey:@"users"];
        if (!usersDic) {
            [self.detaiTableView.header endRefreshing];
            return;
            
        }
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
        _rightArray =arrM;
        self.detaiTableView.delegate =self;
        self.detaiTableView.dataSource=self;
        [self.detaiTableView.header endRefreshing];

    } failure:^(YTKBaseRequest *request) {
        [self.detaiTableView.header endRefreshing];

    }];
}
@end

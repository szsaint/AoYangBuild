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

//#import "AYSearchViewCell.h"

@interface AYSearchController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;//当前空前视图

@property(nonatomic,strong)NSArray *resultArray;//所有公司名称
@end

@implementation AYSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setUI];
   // NSLog(@"-----%@",sortArray);
   
}


-(void)setUI{
    self.title=@"所有公司";
    //tableView
    UITableView *tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    tableView.delegate=self;
    tableView.dataSource=self;
    self.tableView=tableView;
    self.tableView.tableFooterView =[[UIView alloc]init];
    [self.view addSubview:self.tableView];
    [self loadDate];
   
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
        NSMutableArray *arrM =[NSMutableArray array];
        for (NSString *s in [resultDic allKeys]) {
            NSDictionary *realDic =[resultDic valueForKey:s];
            NSString *companyname =[realDic valueForKey:@"name"];
            ConectModel *model = [[ConectModel alloc]init];
            model.name =companyname;
            NSArray *managerArr =realDic[@"manager"];
            if (managerArr.count==0) {
                model.phone =@"未设置";
            }else{
            NSDictionary *managerDic =managerArr[0];
            NSString *phone =managerDic[@"mobile"];
                if (phone.length>0) {
                    model.phone=phone;
                }else{
                    model.phone =@"未设置";
                }
            }
            [arrM addObject:model];
        }
        self.resultArray =arrM;
//        _companyNameArray =arrM;
//        _resultID =keyArrM;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark   ----tableView  delegate------


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.resultArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightTableViewCell *cell =[RightTableViewCell cellWithTableView:tableView identifiter:@"cell"];
    ConectModel *model =self.resultArray[indexPath.row];
    cell.position.text=model.name;
    cell.phoneNumber.text =[NSString stringWithFormat:@"联系电话：%@",model.phone];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ConectModel *model =self.resultArray[indexPath.row];
    if ([model.phone isEqualToString:@"未设置"]) {
        return;
    }
    UIWebView *web =[[UIWebView alloc]init];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",model.phone]]]];
    [self.view addSubview:web];

}


@end

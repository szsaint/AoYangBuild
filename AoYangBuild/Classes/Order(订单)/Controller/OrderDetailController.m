//
//  OrderDetailController.m
//  AoYangBuild
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailCell.h"
#import "OrderDetailToDController.h"

#import "OrderSpeedModel.h"
#import "ChargeApi.h"
#import <MBProgressHUD.h>
#import "OrderHistoryController.h"

@interface OrderDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *resultArray;


@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self loadData];
//    OrderSpeedModel *model =[[OrderSpeedModel alloc]init];
//    model.title=self.title;
//    model.time=[NSString stringWithFormat:@"%@",[NSDate date]];
//    model.detailTitle=@"本次缴费560元，缴费至张家港水利有限公司";
//    model.price=@"￥560";
//    self.resultArray=@[model];
}
-(void)loadData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ChargeApi *api =[[ChargeApi alloc]initWithNeed];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        id result =[request responseJSONObject];
        if ([result isKindOfClass:[NSArray class]]) {
            [self showEmpty];
            return ;
        }
        NSDictionary *resultDic =result;
        NSMutableArray *arrM =[NSMutableArray array];
        for (NSString *key in resultDic.allKeys) {
            NSDictionary *dic =resultDic[key];
            OrderSpeedModel *model =[OrderSpeedModel modelWithDic:dic];
            [arrM addObject:model];
        }
        self.resultArray =arrM;
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}

-(void)setUI{
    self.view.backgroundColor =[UIColor whiteColor];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.tableView.tableFooterView =[[UIView alloc]init];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"未缴",@"已缴"]];
    segment.selectedSegmentIndex=0;
    segment.frame =CGRectMake(0, 0, SCREEN_WIDTH-150, 30);
    segment.tintColor=[UIColor whiteColor];
    [segment addTarget:self action:@selector(segmentIndexDidChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView=segment;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"order_cell";
    OrderDetailCell *cell =[OrderDetailCell cellWithTableView:tableView identifier:ID];
    cell.model=self.resultArray[indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderDetailToDController *toVC =[[OrderDetailToDController alloc]init];
    toVC.model =self.resultArray[indexPath.row];////、、、、、、、、、、
    [self.navigationController pushViewController:toVC animated:YES];
}
-(void)segmentIndexDidChange:(UISegmentedControl *)segement{
    if (segement.selectedSegmentIndex==1) {
        if (self.childViewControllers.count==0) {
            OrderHistoryController *orderHisVC =[[OrderHistoryController alloc]init];
            [self addChildViewController:orderHisVC];
            orderHisVC.view.frame =CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
            [self.view addSubview:orderHisVC.view];
        }else{
            self.childViewControllers[0].view.hidden=NO;
        }

    }else if (segement.selectedSegmentIndex==0){
        self.childViewControllers[0].view.hidden=YES;
    }
}
@end

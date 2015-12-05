//
//  OrderHistoryController.m
//  AoYangBuild
//
//  Created by wl on 15/11/10.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "OrderHistoryController.h"
#import "OrderDetailToDController.h"

#import "OrderDetailCell.h"
#import "OrderSpeedModel.h"
#import "ChargeApi.h"
#import <MBProgressHUD.h>

@interface OrderHistoryController ()
@property (nonatomic,strong)NSArray *resultArray;

@end

@implementation OrderHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self loadDate];
    

    
}
-(void)loadDate{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    ChargeApi *api =[[ChargeApi alloc]initHad];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        if ([result  isKindOfClass:[NSArray class]]) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
}

#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"history_cell";
    OrderDetailCell *cell =[OrderDetailCell cellWithTableView:tableView identifier:ID];
    cell.model=self.resultArray[indexPath.row];
    cell.needPay.hidden=YES;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OrderDetailToDController *toVC =[[OrderDetailToDController alloc]init];
    toVC.model =self.resultArray[indexPath.row];////、、、、、、、、、、
    toVC.type=OrderDetailToDControllerTypeHadPay;
    [self.navigationController pushViewController:toVC animated:YES];
}

@end

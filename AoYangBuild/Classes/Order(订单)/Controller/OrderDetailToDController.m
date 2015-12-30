//
//  OrderDetailToDController.m
//  AoYangBuild
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "OrderDetailToDController.h"
#import "OrderDetailCell.h"
#import "OrderSpeedModel.h"
#import "PayOrderController.h"

#define headerH  80

@interface OrderDetailToDController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *detailTitleLab;

@end

@implementation OrderDetailToDController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=vcColor;
    if (self.type==OrderDetailToDControllerTypeHadPay) {
        self.title=@"费用详情";
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.tableFooterView=[[UIView alloc]init];
        self.tableView.backgroundColor=[UIColor whiteColor];
        self.view=self.tableView;
        OrderDetailCell *cell =[OrderDetailCell cellWithTableView:self.tableView identifier:@"header"];
        cell.frame=CGRectMake(0, 0, SCREEN_WIDTH, headerH);
        cell.model=self.model;
        cell.detailTitle.hidden=YES;
        cell.needPay.hidden=YES;
        self.tableView.tableHeaderView=cell;
        [self detailLab];
    }else{
        [self setUI];}
}
-(void)setUI{
    self.title=@"费用详情";
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    OrderDetailCell *cell =[OrderDetailCell cellWithTableView:self.tableView identifier:@"header"];
    cell.frame=CGRectMake(0, 0, SCREEN_WIDTH, headerH);
    cell.model=self.model;
    cell.detailTitle.hidden=YES;
    self.tableView.tableHeaderView=cell;
    
    //go to pay
    UIButton *payBtn =[[UIButton alloc]initWithFrame:CGRectMake(0,  SCREEN_HEIGHT-64-44, SCREEN_WIDTH, 44)];
    [payBtn setBackgroundColor:appColor];
    [payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    [self detailLab];
   
}
-(void)detailLab{
    UILabel *detailTitleLab =[[UILabel alloc]init];
    UIFont *font =[UIFont systemFontOfSize:16];
    detailTitleLab.font=font;
    CGSize detailTitleS =[self.model.detailTitle boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:Nil].size;
    detailTitleLab.frame=CGRectMake(10, 8, SCREEN_WIDTH-20, detailTitleS.height+5);
    detailTitleLab.text=self.model.detailTitle;
    detailTitleLab.numberOfLines=0;
    self.detailTitleLab =detailTitleLab;
}
-(void)payBtnOnClick:(UIButton *)sender{
    PayOrderController *payVC =[[PayOrderController alloc]init];
    payVC.model=self.model;
    [self.navigationController pushViewController:payVC animated:YES];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.detailTitleLab.height+16>SCREEN_HEIGHT-64 - headerH-44) {
        return self.detailTitleLab.height+16;
    }else{
        return SCREEN_HEIGHT-64 - headerH-44;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"cell";
    UITableViewCell *cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=vcColor;
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH-12, 1)];
    line.backgroundColor=[UIColor grayColor];
    line.alpha=0.3;
    [cell.contentView addSubview:line];
    [cell.contentView addSubview:self.detailTitleLab];
    cell.contentView.backgroundColor=[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:0.3];
    return cell;
}

@end

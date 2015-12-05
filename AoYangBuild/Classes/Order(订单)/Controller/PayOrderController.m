//
//  PayOrderController.m
//  AoYangBuild
//
//  Created by wl on 15/11/10.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "PayOrderController.h"

#define marginLeft 30
#define cellH   60

@interface PayOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UIView *zhifubaoCell;
@property (nonatomic,strong)UIView *weixinCell;

@property (nonatomic,assign)NSInteger currentSelectedIndex;//当前选中的索引;

@end

@implementation PayOrderController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"在线支付";
    self.view.backgroundColor=vcColor;
    [self addObserver:self forKeyPath:@"currentSelectedIndex" options:NSKeyValueObservingOptionNew context:nil];
    [self setUI];
    
}
-(void)setUI{
    
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView=[self creatHeaderViewWithMoney:@"560"];
    self.tableView.tableFooterView=[self creatFooter];
    
    self.zhifubaoCell =[self creatCellWithImage:[UIImage imageNamed:@"zhifubao"] title:@"支付宝支付" tag:100];
    self.weixinCell =[self creatCellWithImage:[UIImage imageNamed:@"weixin"] title:@"微信支付" tag:101];
}
-(UIView *)creatHeaderViewWithMoney:(NSString *)money{
    UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    header.backgroundColor=[UIColor whiteColor];
    
    for (int i=0; i<2; i++) {
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 49+50*i, SCREEN_WIDTH, 1)];
        line.backgroundColor=vcColor;
        [header addSubview:line];
    }
    UILabel *needlab =[self creatLab];
    needlab.frame=CGRectMake(marginLeft, 0, 60, 50);
    needlab.text=@"缴费金额";
    [header addSubview:needlab];
    
    UILabel *moneylab =[self creatLab];
    moneylab.frame =CGRectMake(CGRectGetMaxX(needlab.frame)+10, 0, 100, 50);
    moneylab.textColor=[UIColor grayColor];
    moneylab.text=[NSString stringWithFormat:@"%@元",money];
    [header addSubview:moneylab];
    
    UILabel *waylab =[self creatLab];
    waylab.frame =CGRectMake(marginLeft, 50, SCREEN_WIDTH-2*marginLeft, 50);
    waylab.text=@"支付方式";
    [header addSubview:waylab];
    return header;
}
-(UILabel *)creatLab{
    UILabel *lab =[[UILabel alloc]init];
    lab.font=[UIFont systemFontOfSize:15];
    return lab;
}
// 300*50
-(UIView *)creatFooter{
    UIView *footer =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    CGFloat ww =SCREEN_WIDTH/375.0*300;
    UIButton *payBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, ww, 50)];
    [payBtn setImage:[UIImage imageNamed:@"payorders"] forState:UIControlStateSelected];
    [payBtn setImage:[UIImage imageNamed:@"payorder"] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(goToPay:) forControlEvents:UIControlEventTouchUpInside];
    payBtn.selected=YES;
    [footer addSubview:payBtn];
    payBtn.center=footer.center;
    return footer;
}

-(void)goToPay:(UIButton *)sender{
    NSLog(@"确认支付");
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //cell.userInteractionEnabled=NO;//关闭cell的用户交互
    }
    if (indexPath.row==0) {
        [cell addSubview:self.zhifubaoCell];
    }else if (indexPath.row==1){
        [cell addSubview:self.weixinCell];
    }
    return cell;
}
-(UIView *)creatCellWithImage:(UIImage *)image title:(NSString *)title tag:(NSInteger)tag{
    
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, cellH)];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [view addGestureRecognizer:tap];
    view.tag=tag;
    
    //52*34
    UIImageView *icon =[[UIImageView alloc]initWithFrame:CGRectMake(marginLeft, (cellH-34)/2, 52, 34)];
    icon.image=image;
    [view addSubview:icon];
    
    CGFloat xx =marginLeft+52+12;
    UILabel *titleLab =[[UILabel alloc]initWithFrame:CGRectMake(xx, 0, SCREEN_WIDTH-xx-marginLeft-18, cellH)];
    titleLab.font=[UIFont systemFontOfSize:14];
    titleLab.text=title;
    [view addSubview:titleLab];
    //18*18
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLab.frame), (cellH-18)/2, 18, 18)];
    [btn setImage:[UIImage imageNamed:@"Uncheck button 2"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Select the button 2"] forState:UIControlStateSelected];
    //btn.adjustsImageWhenHighlighted=NO;
    btn.userInteractionEnabled=NO;
    [view addSubview:btn];
    
    
    return view;
    
}
-(void)tap:(UITapGestureRecognizer *)sender{
    if (self.currentSelectedIndex==sender.view.tag)return;
    self.currentSelectedIndex =sender.view.tag;
    UIButton *footerBtn =self.tableView.tableFooterView.subviews.lastObject;
    footerBtn.selected=NO;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    //object  当前控制器

    NSInteger value =[[change objectForKey:@"new"] integerValue];
    if (value==100) {
        UIButton *btn =  self.zhifubaoCell.subviews.lastObject;
        btn.selected=YES;
        UIButton *btns =  self.weixinCell.subviews.lastObject;
        btns.selected=NO;
    }else if(value==101){
        UIButton *btn =  self.zhifubaoCell.subviews.lastObject;
        btn.selected=NO;

        UIButton *btns =  self.weixinCell.subviews.lastObject;
        btns.selected=YES;
    }
    
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"currentSelectedIndex"];
}
@end

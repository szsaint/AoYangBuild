//
//  OrderController.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "OrderController.h"
#import "AYButton.h"
#import "OrderDetailController.h"

@interface OrderController ()
@property (nonatomic,strong)NSArray *itemsArray;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation OrderController
-(instancetype)init{
    if (self=[super init]) {
        self.title=@"预定";
        self.tabBarItem.image=[UIImage imageNamed:@"Reservation Icon（Selected）"];
        self.tabBarItem.selectedImage =[UIImage imageNamed:@"Reservation Icon（not Selected）"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUI];
}

-(void)setUI{
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.view=self.tableView;
    self.itemsArray =@[@"水费",@"电费",@"宽带费",@"物业费",@"会议室预定",@"健身房预定"];
    CGFloat ww =SCREEN_WIDTH/3;
    CGFloat hh =120;
    for (int i=0; i<self.itemsArray.count; i++) {
        int row =i/3;
        int coloum =i%3;
        AYButton *btn =[[AYButton alloc]initWithFrame:CGRectMake(coloum*ww, hh*row, ww, hh)];
        btn.titleLab.text=self.itemsArray[i];
        btn.imageView.image=[UIImage imageNamed:self.itemsArray[i]];
        [self.tableView addSubview:btn];
        btn.tag=100+i;
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemBtnOnClick:)];
        [btn addGestureRecognizer:tap];
    }
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor=[UIColor lightGrayColor];
    line.alpha=0.3;
    [self.tableView addSubview:line];
    
}
-(void)itemBtnOnClick:(UITapGestureRecognizer *)sender{
    NSInteger index =sender.view.tag-100;
    if (index<4) {
        OrderDetailController *detailVC =[[OrderDetailController alloc]init];
        detailVC.hidesBottomBarWhenPushed=YES;
        detailVC.title=self.itemsArray[index];
        [self.navigationController pushViewController:detailVC animated:YES];

    }
    NSLog(@"%ld",(long)index);
}
@end

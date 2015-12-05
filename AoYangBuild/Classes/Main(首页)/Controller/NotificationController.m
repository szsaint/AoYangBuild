//
//  NotificationController.m
//  AoYangBuild
//
//  Created by wl on 15/10/22.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "NotificationController.h"
#import "AYNotificationCell.h"
#import "AYArticleDetailController.h"
#import <MJRefresh.h>

#import "NewsApi.h"
#import "AYAticleModel.h"


@interface NotificationController ()

@end

@implementation NotificationController{
    NSInteger _page;
    NSArray *_resultArray;
    NSArray *_modelArray;
}
-(instancetype)init{
    if (self=[super init]) {
        self.title=@"通知";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.tableView.footer =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    [self.tableView.header beginRefreshing];
    self.view.backgroundColor=vcColor;
    
}
-(void)loadData{
    _page=1;
    NewsApi *api =[[NewsApi alloc]initWithItem:@"notice" andPage:0];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *result =[request responseJSONObject];
        _resultArray =result;
        NSMutableArray *arrM =[NSMutableArray array];
        for (int i =0; i<result.count; i++) {
            NSDictionary *dic =result[i];
            AYAticleModel *model =[AYAticleModel articleModelWithDic:dic];
            [arrM addObject:model];
        }
        _modelArray =arrM;
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        [self.tableView.footer resetNoMoreData];
    } failure:^(YTKBaseRequest *request) {
        NSLog(@"加载失败");
        [self.tableView.header endRefreshing];
    }];
}
-(void)loadMoreData{
    _page++;
    NewsApi *api =[[NewsApi alloc]initWithItem:@"notice" andPage:_page];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *result =[request responseJSONObject];
        NSMutableArray *resultM =[NSMutableArray array];
        [resultM addObjectsFromArray:_resultArray];
        [resultM addObjectsFromArray:result];
        _resultArray=resultM;
        NSMutableArray *arrM =[NSMutableArray array];
        [arrM addObjectsFromArray:_modelArray];
        for (int i =0; i<result.count; i++) {
            NSDictionary *dic =result[i];
            AYAticleModel *model =[AYAticleModel articleModelWithDic:dic];
            [arrM addObject:model];
        }
        _modelArray=arrM;
        [self.tableView reloadData];
        if (result==nil||result.count<10) {
            [self.tableView.footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.footer endRefreshing];
        }

    } failure:^(YTKBaseRequest *request) {
        [self.tableView.footer endRefreshing];
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _modelArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID =@"notification_cell";
    AYNotificationCell *cell =[AYNotificationCell cellWithTableViewTableView:tableView identifier:ID];
    cell.model=_modelArray[indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AYArticleDetailController *articleVC =[[AYArticleDetailController alloc]init];
    NSDictionary *dic =_resultArray[indexPath.section];
    articleVC.detailDic=dic;
    articleVC.hidesBottomBarWhenPushed=YES;
    [self.parentViewController.navigationController pushViewController:articleVC animated:YES];
}
@end

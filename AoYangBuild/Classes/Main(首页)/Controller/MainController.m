//
//  MainController.m
//  AoYangBuild
//
//  Created by wl on 15/10/20.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "MainController.h"
#import "NotificationController.h"

#import "AYSegment.h"
#import "AYHeaderView.h"
#import "AYArticleCell.h"

#import "AYArticleFrameModel.h"
//处理数据 暂时引用
#import "AYAticleModel.h"
#import "AYArticleDetailController.h"

#import <MJRefresh.h>

#import "NewsApi.h"





@interface MainController ()<AYSegmentDelgate,UITableViewDelegate,UITableViewDataSource,AYHeaderViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIScrollView *backScroll;

@property(nonatomic,strong)NSArray *headerResultArr;

@end

@implementation MainController{
    NSInteger _page;
    NSArray *_resultArray;
    NSArray *_modelArr;

}
-(id)init{
    if (self=[super init]) {
        self.title=@"文章";
        self.tabBarItem.image=[UIImage imageNamed:@"Home icon（not Selected）"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setUI];
    [self.tableView.header beginRefreshing];
    [self loadheader];
}
#pragma mark 加载大标题新闻
-(void)loadheader{
    NewsApi *api =[[NewsApi alloc]initWithItem:@"slider" andPage:0];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *result =[request responseJSONObject];
        self.headerResultArr =result;
        if (result==nil||result.count==0) {
            return ;
        }else{
            //header
            AYHeaderView *header =[[AYHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 230)];
            header.array=result;
            header.delegate=self;
            self.tableView.tableHeaderView=header;
        }
        [self loadDate];
    } failure:^(YTKBaseRequest *request) {
        [self.tableView.header endRefreshing];
    }];
}
#pragma mark 加载列表新闻
-(void)loadDate{
    _page=1;
    NewsApi *api =[[NewsApi alloc]initWithItem:@"news" andPage:0];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        _resultArray =[request responseJSONObject];
        NSMutableArray *arrM =[NSMutableArray array];
        for (int i =0; i<_resultArray.count; i++) {
            NSDictionary *dic =_resultArray[i];
            AYAticleModel *model =[AYAticleModel articleModelWithDic:dic];
            AYArticleFrameModel *frameModel =[[AYArticleFrameModel alloc]init];
            frameModel.model=model;
            [arrM addObject:frameModel];
        }
        _modelArr=arrM;
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
    NewsApi *api =[[NewsApi alloc]initWithItem:@"news" andPage:_page];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *result =[request responseJSONObject];
        NSMutableArray *resultM =[NSMutableArray array];
        [resultM addObjectsFromArray:_resultArray];
        [resultM addObjectsFromArray:result];
        _resultArray =resultM;
        NSMutableArray *arrM =[NSMutableArray array];
        [arrM addObjectsFromArray:_modelArr];
        for (int i =0; i<result.count; i++) {
            NSDictionary *dic =result[i];
            AYAticleModel *model =[AYAticleModel articleModelWithDic:dic];
            AYArticleFrameModel *frameModel =[[AYArticleFrameModel alloc]init];
            frameModel.model=model;
            [arrM addObject:frameModel];
        }
        _modelArr=arrM;
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
-(void)setUI{
    
    UIScrollView *backScroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.height)];
    backScroll.backgroundColor=[UIColor clearColor];
    backScroll.showsHorizontalScrollIndicator=NO;
    backScroll.showsVerticalScrollIndicator=NO;
    backScroll.contentSize=CGSizeMake(SCREEN_WIDTH*2, 0);
    backScroll.scrollEnabled=NO;
    self.backScroll=backScroll;
    self.backScroll.backgroundColor=[UIColor whiteColor];
    self.view=self.backScroll;
    //nav titleView212*34 --81.5
    //CGFloat hh =SCREEN_HEIGHT/667.0f *30;
    CGFloat WW =SCREEN_WIDTH/667.0f*212;
    AYSegment *segment =[[AYSegment alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-WW)/2, 0, WW, 30)];
    segment.delegate=self;
    self.navigationItem.titleView=segment;
    
    //tableView
    UITableView *tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.backScroll.height-49-64)];
    self.tableView=tableView;
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadheader];
    }];
    self.tableView.footer =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    self.tableView.footer.automaticallyHidden=YES;

    [self.backScroll addSubview:self.tableView];
    
   
    
}

#pragma mark  -----segmentDelegate------
-(void)AYSegment:(AYSegment *)segment didSelectedAtIndex:(NSInteger)index{
    
   // NSLog(@"index:%ld",(long)index);
    CGFloat yy =self.backScroll.contentOffset.y;
    if (index==0) {
        [self.backScroll setContentOffset:CGPointMake(0, yy) animated:NO];
    }else{
        [self.backScroll setContentOffset:CGPointMake(SCREEN_WIDTH,yy) animated:NO];
        if (self.childViewControllers.count==0) {
            //right view
            NotificationController *NotificVC =[[NotificationController alloc]init];
            [self addChildViewController:NotificVC];
            NotificVC.view.frame=CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, self.backScroll.height-49);
            [self.backScroll addSubview:NotificVC.view];

        }
    }
}


#pragma mark  -----tableView  delegate ------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AYArticleFrameModel *frameModel =_modelArr[indexPath.row];
    NSString *indexfier =nil;
    if (frameModel.model.imageType==0) {
        indexfier=@"no_pic";
    }else if(frameModel.model.imageType==1){
        indexfier=@"one_pic";
    }else{
        indexfier=@"more_pic";
    }

    AYArticleCell *cell =[AYArticleCell cellWithTableView:tableView indextifier:indexfier];
    //NSLog(@"%@",NSStringFromCGRect(frameModel.titleF));
    cell.frameModel=frameModel;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   AYArticleFrameModel *frameModel =_modelArr[indexPath.row];
    return frameModel.cellH;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AYArticleDetailController *detailVC =[[AYArticleDetailController alloc]init];
    NSDictionary *dic =_resultArray[indexPath.row];
    detailVC.detailDic=dic;
    detailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
#pragma mark headerViewOnClick delegate
-(void)AYHeaderView:(AYHeaderView *)header clickOnIndex:(NSInteger)index{
    AYArticleDetailController *detailVC =[[AYArticleDetailController alloc]init];
    NSDictionary *dic =self.headerResultArr[index];
    detailVC.detailDic=dic;
    detailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailVC animated:YES];

}
@end

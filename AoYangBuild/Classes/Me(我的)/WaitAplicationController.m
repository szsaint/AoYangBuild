//
//  WaitAplicationController.m
//  AoYangBuild
//
//  Created by wl on 15/11/30.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "WaitAplicationController.h"
#import "WaitAplicatinCell.h"
#import "NewOrAplicationApi.h"
#import <MBProgressHUD.h>
#import "WaitAplicationModel.h"
#import "AgreeAplicationApi.h"

@interface WaitAplicationController ()<WaitAplicatinCellDelegate>
@property (nonatomic,strong)UILabel *notingLab;

@end

@implementation WaitAplicationController{
    NSArray *_resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUI{
    self.tableView.tableFooterView =[[UIView alloc]init];
    UILabel *nothingLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    nothingLab.textColor=[UIColor lightGrayColor];
    nothingLab.text=@"暂无申请数据";
    [self.view addSubview:nothingLab];
    CGPoint center =self.view.center;
    center.y-=64;
    nothingLab.center=center;
    nothingLab.hidden=YES;
    nothingLab.textAlignment=NSTextAlignmentCenter;
    self.notingLab=nothingLab;
    [self loadDate];
}
-(void)loadDate{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NewOrAplicationApi *api =[[NewOrAplicationApi alloc]initWithNothing];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        if ([result isKindOfClass:[NSArray class]]){
            NSArray *arr =result;
            if (arr.count==0) {
                self.notingLab.hidden=NO;
                _resultArray=nil;
                [self.tableView reloadData];
            }
        }else{
            NSDictionary *resultDic =result;
            NSMutableArray *arrM =[NSMutableArray array];
            for (NSString *key in resultDic.allKeys) {
                NSDictionary *dic =resultDic[key];
                WaitAplicationModel *model =[WaitAplicationModel aplicationModelWithDic:dic];
                [arrM addObject:model];
            }
            _resultArray =arrM;
            [self.tableView reloadData];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];

    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaitAplicatinCell *cell =[WaitAplicatinCell waitAplicatinCellWithTableView:tableView identifier:@"cell"];
    cell.delegate=self;
    cell.tag=indexPath.row;
    WaitAplicationModel *model =_resultArray[indexPath.row];
    cell.textLabel.text=model.name;
    //cell.detailTextLabel.text=@"12345678901";
    cell.state=model.state;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)WaitAplicatinCell:(WaitAplicatinCell *)cell acceptBtnOnClick:(UIButton *)sender{
    //审核申请
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WaitAplicationModel *model =_resultArray[cell.tag];
    AgreeAplicationApi *api =[[AgreeAplicationApi alloc]initWithID:model.ID];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        [self loadDate];
        [hud hide:YES];
    } failure:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        [hud hide:YES];
    }];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  AllCompanyController.m
//  AoYangBuild
//
//  Created by wl on 15/11/28.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AllCompanyController.h"
#import "AYSearchViewCell.h"

#import "SearchCompanyApi.h"
#import <MBProgressHUD.h>

#import "NewOrAplicationApi.h"
#import <SVProgressHUD.h>

@interface AllCompanyController ()<UIAlertViewDelegate>
@property (nonatomic,assign)NSInteger curentIndex;

@end

@implementation AllCompanyController{
    NSArray *_resultID;
    NSArray *_companyNameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}

-(void)setUI{
    self.title =@"选择公司";
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.curentIndex=-1;
    //leftBtn
    UIButton *leftBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn setTitle:@"确认" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    
    [self loadDate];
//    _companyNameArray =[NSArray arrayWithObjects:@"angellixf科技有限公司",@"李小明科技有限公司",@"Hailey科技有限公司",@"Gibson科技有限公司",@"Abbey科技有限公司",@"Hagan科技有限公司",@"hahn",@"daojianmahun科技有限公司科技有限公司",@"Hailay",@"vicky",@"Ham科技有限公司",@"小小科技有限公司",@"bannial科技有限公司",@"bannial科技有限公司",@"Hailay",@"vicky",@"Ham科技有限公司",@"上海医疗器械有限公司",@"华阳有限公司",@"傲视集团",@"东南研究所",@"张家港物流有限公司",@"国际贸易有限公司",@"和罚款和发放号拉黑",nil];
}
-(void)loadDate{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    SearchCompanyApi *api =[[SearchCompanyApi alloc]initWithCompany:nil];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSDictionary *resultDic =[request responseJSONObject];
        NSMutableArray *keyArrM =[NSMutableArray array];
        NSMutableArray *arrM =[NSMutableArray array];
            for (NSString *s in [resultDic allKeys]) {
                [keyArrM addObject:s];
                NSDictionary *realDic =[resultDic valueForKey:s];
                NSString *company =[realDic valueForKey:@"name"];
                [arrM addObject:company];
            }
        _companyNameArray =arrM;
        _resultID =keyArrM;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(void)leftBtnOnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightBtnOnClick:(UIButton *)sender{
    if (self.curentIndex<0){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请先选择要申请的公司" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    MBProgressHUD *HUD  =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText =@"申请中";
    NewOrAplicationApi *api =[[NewOrAplicationApi alloc]initWithCompanyID:_resultID[self.curentIndex]];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        [HUD hide:YES];
        [SVProgressHUD showSuccessWithStatus:@"申请成功"];
        [self performSelector:@selector(leftBtnOnClick:) withObject:nil afterDelay:1.0f];
    } failure:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        [HUD hide:YES];
        [SVProgressHUD showErrorWithStatus:@"申请失败"];
        NSLog(@"%@",result);

    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _companyNameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AYSearchViewCell *cell = [AYSearchViewCell cellWithTableView:tableView];
    cell.businessName.text=_companyNameArray[indexPath.row];
    if (indexPath.row==self.curentIndex) {
        cell.selectBtn.selected=YES;
    }else{
        cell.selectBtn.selected=NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AYSearchViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.selected=!cell.selectBtn.selected;
    if (cell.selectBtn.selected) {
        self.curentIndex =indexPath.row;
    }else{
        self.curentIndex=-1;
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    AYSearchViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    cell.selectBtn.selected=NO;
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

//
//  CreatCompanyController.m
//  AoYangBuild
//
//  Created by wl on 15/11/28.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "CreatCompanyController.h"
#import "NewOrAplicationApi.h"
#import <MBProgressHUD.h>


@interface CreatCompanyController ()<UITextViewDelegate>
@property (nonatomic,strong)UITextField *company;
@property (nonatomic,strong)UITextField *phone;
@property (nonatomic,strong)UITextView *brief;//公司简介

@end

@implementation CreatCompanyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=vcColor;
    [self setUI];
}
-(void)setUI{
    self.title =@"创建公司";
    self.tableView.tableFooterView =[[UIView alloc]init];
    
    UIButton *left =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [left setTitle:@"取消" forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:left];
    
    UIButton *right =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [right setTitle:@"确定" forState:UIControlStateNormal];
    [right addTarget:self action:@selector(rightBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:right];
    
    CGFloat margin =12;
    self.company =[[UITextField alloc]initWithFrame:CGRectMake(margin, margin, SCREEN_WIDTH-2*margin, 45)];
    self.company.placeholder =@"公司名称";
    self.company.backgroundColor =[UIColor whiteColor];
    self.company.layer.cornerRadius=6;
    [self.view addSubview:self.company];
    
    self.phone =[[UITextField alloc]initWithFrame:CGRectMake(margin, margin+45+margin, SCREEN_WIDTH-2*margin, 45)];
    self.phone.placeholder =@"公司电话(非必填)";
    self.phone.keyboardType=UIKeyboardTypeNamePhonePad;
    self.phone.backgroundColor =[UIColor whiteColor];
    self.phone.layer.cornerRadius=6;
    [self.view addSubview:self.phone];
    
    self.brief =[[UITextView alloc]initWithFrame:CGRectMake(margin, margin*3+90, SCREEN_WIDTH-2*margin, SCREEN_HEIGHT-64-margin*4-90-44)];
    self.brief.text=@"公司简介(非必填)";
    self.brief.font=[UIFont systemFontOfSize:15];
    self.brief.textColor=[UIColor lightGrayColor];
    self.brief.delegate=self;
    [self.view addSubview:self.brief];
    

}
-(void)rightBtnOnClick:(UIButton *)sender{
    [self.view endEditing:YES];
    if (self.company.text.length==0) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请正确输入公司名称" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        if ([self.brief.text isEqualToString:@"公司简介(非必填)"]) {
            self.brief.text=@"";
        }
        //干些什么
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NewOrAplicationApi *api =[[NewOrAplicationApi alloc]initWithCompanyName:self.company.text phone:self.phone.text brief:self.brief.text];
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            id result =[request responseJSONObject];
            NSLog(@"%@",result);
            NSString *companyname =[result valueForKey:@"name"];
            [[NSUserDefaults standardUserDefaults]setValue:companyname forKey:@"companyname"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [SVProgressHUD showSuccessWithStatus:@"创建成功"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"creatSuccess" object:companyname];
            [self performSelector:@selector(leftBtnOnClick:) withObject:nil afterDelay:1.0f];
            
        } failure:^(YTKBaseRequest *request) {
            id result =[request responseJSONObject];
            NSLog(@"%@",result);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [SVProgressHUD showErrorWithStatus:@"创建失败"];

        }];
        
    }
    
}
-(void)leftBtnOnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.tableView) {
        [self.view endEditing:YES];
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.textColor =[UIColor blackColor];
    if ([textView.text isEqualToString:@"公司简介(非必填)"]) {
        textView.text=@"";
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length==0) {
        textView.textColor=[UIColor lightGrayColor];
        textView.text=@"公司简介(非必填)";
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

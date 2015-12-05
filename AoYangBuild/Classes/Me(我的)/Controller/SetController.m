//
//  SetController.m
//  AoYangBuild
//
//  Created by wl on 15/11/6.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "SetController.h"
#import "AYMeCell.h"
#import "LoginController.h"
#import "UserManeger.h"
#import "ReSetUserInfoApi.h"
#import <MBProgressHUD.h>

#define vcColor [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]
@interface SetController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSString *nickname;//用户名

@property (nonatomic,copy)NSString *userPhoneNumber;//用户手机号

@end

@implementation SetController
-(NSString *)nickname{
    if (!_nickname) {
        _nickname =[[NSUserDefaults standardUserDefaults]objectForKey:@"nickname"];
        if (_nickname==nil) {
            _nickname =@"输入昵称";
        }
    }
    return _nickname;
}
-(NSString *)userPhoneNumber{
    if (!_userPhoneNumber) {
        _userPhoneNumber=[[NSUserDefaults standardUserDefaults]objectForKey:@"mobile"];
    }
    return _userPhoneNumber;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        UIView *footer =[self headerView];
        _tableView.tableFooterView=footer;
        _tableView.backgroundColor=vcColor;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)setUI{
    self.title =@"我的设置";
    self.view=self.tableView;
    self.tableView.contentInset=UIEdgeInsetsMake(20, 0, 0, 0);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"set_cell";
    NSArray *titleArr =@[self.nickname,@"手机号",@"密码设置"];
    NSArray *iconArr =@[@"user",@"Phone",@"passWord"];
    AYMeCell *cell =[AYMeCell cellWithTableView:tableView identifier:ID];
    cell.imageName=iconArr[indexPath.row];
    cell.title=titleArr[indexPath.row];
    if (indexPath.row==1&&self.userPhoneNumber) {
        cell.detailTitle=self.userPhoneNumber;
    }
    return cell;

}

-(UIView *)headerView{
    UIView *header =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    header.backgroundColor=vcColor;
    UIButton *exitBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 50)];
    [exitBtn setTitle:@"退出账户" forState:UIControlStateNormal];
    exitBtn.layer.cornerRadius=6;
    exitBtn.layer.masksToBounds=YES;
    [exitBtn setBackgroundColor:appColor];
    [exitBtn addTarget:self action:@selector(exitBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:exitBtn];
    exitBtn.center=header.center;
    return header;
}
-(void)exitBtnOnClick:(UIButton *)sender{
    UserManeger *manage =[[UserManeger alloc]init];
    [manage deleteUserInfo];
    LoginController *loginVc =[[LoginController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController=loginVc;
  

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"修改昵称" message:@"昵称长度2到6个字符以内" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle =UIAlertViewStylePlainTextInput;
        alert.tag=0;
        UITextField *textfield =[alert textFieldAtIndex:0];
        textfield.placeholder=@"请输入您要修改的昵称";
        [alert show];
    }else if (indexPath.row==2){
//        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"修改密码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alert.alertViewStyle=UIAlertViewStyleLoginAndPasswordInput;
//        alert.tag=1;
//        UITextField *textfield =[alert textFieldAtIndex:0];
//        textfield.placeholder=@"密码长度不得低于6个字符";
//        textfield.keyboardType=UIKeyboardTypeASCIICapable;
//        
//        UITextField *textfield1 =[alert textFieldAtIndex:1];
//        textfield1.placeholder=@"再次确认密码";
//        textfield1.keyboardType=UIKeyboardTypeASCIICapable;
//        [alert show];
        UIAlertView *alet =[[UIAlertView alloc]initWithTitle:@"提示" message:@"此功能暂不支持" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alet show];
        
    }else if (indexPath.row==1){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"修改手机号" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle =UIAlertViewStylePlainTextInput;
        alert.tag=1;
        UITextField *textfield =[alert textFieldAtIndex:0];
        textfield.placeholder=@"请输入您的手机号";
        textfield.keyboardType=UIKeyboardTypeNumberPad;
        [alert show];

    }
    
}

#pragma mark  alertView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==0){
        //修改昵称
    if (buttonIndex==1) {
        UITextField *textfield =[alertView textFieldAtIndex:0];
        if (textfield.text.length<2||textfield.text.length>6) {
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"请正确输入昵称"  delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];

        }else{
            BOOL ilegal =[self isHaveIllegalChar:textfield.text];
        if (ilegal) {
            // have ilegall character
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"您输入的昵称含有非法字符" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            self.nickname=textfield.text;
           //
            [self reSetNickname];
        }
        }}}else if (alertView.tag==1){
            if (buttonIndex==1) {
                UITextField *textfield =[alertView textFieldAtIndex:0];
                if (textfield.text.length!=11) {
                    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"请正确输入手机号"  delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                    [alert show];

                }else{
                    self.userPhoneNumber =textfield.text;
                    [self reSetPhone];
                }
            }
        }
    
    
}
-(void)swichRootVC{
    LoginController *loginVC =[[LoginController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController=loginVC;
}

- (BOOL)isHaveIllegalChar:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location<str.length;
}
#pragma mark  textfield  delegate
-(void)textFieldDidEndEditing:(UITextField *)textField{

}

-(void)reSetNickname{
   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText =@"正在更新";
    ReSetUserInfoApi *api =[[ReSetUserInfoApi alloc]initWithNickname:self.nickname];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id result = [request responseJSONObject];
        NSLog(@"%@",result);
        NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
        [user setObject:self.nickname forKey:@"nickname"];
        [user synchronize];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"resetNickname" object:nil];
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(YTKBaseRequest *request) {
        id result = [request responseJSONObject];
        NSLog(@"%@",result);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
}

-(void)reSetPhone{
   MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText =@"正在更新";
    ReSetUserInfoApi *api =[[ReSetUserInfoApi alloc]initWithPhone:self.userPhoneNumber];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id result = [request responseJSONObject];
        NSLog(@"%@",result);
        NSUserDefaults *user =[NSUserDefaults standardUserDefaults];
        [user setObject:self.userPhoneNumber forKey:@"mobile"];
        [user synchronize];
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failure:^(YTKBaseRequest *request) {
        id result = [request responseJSONObject];
        NSLog(@"%@",result);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}








@end

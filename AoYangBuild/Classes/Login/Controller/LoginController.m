//
//  LoginController.m
//  AoYangBuild
//
//  Created by wl on 15/10/19.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "LoginController.h"
#import "SwichRegistController.h"
#import "AppDelegate.h"
#import <MBProgressHUD.h>
#import "UserInfoApi.h"
#import <AFNetworking.h>

#import "UserManeger.h"
#import "AppDelegate.h"


@interface LoginController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *phoneNumber;
@property(nonatomic,strong)UITextField *password;
@property(nonatomic,strong)UIView *back;

@property(nonatomic,assign)BOOL isShow;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardStadus) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardStadusHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)setUI{
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    UIView *back =[[UIView alloc]init];
    back.backgroundColor=[UIColor clearColor];
    self.back=back;
    
    //手机号
    self.phoneNumber = [self creatTextFieldWithFrame:CGRectMake(35, 0, SCREEN_WIDTH-70, 40) placeHolder:@" 输入手机号" headeImage:@"Enter a phone number button"];
    self.phoneNumber.keyboardType =UIKeyboardTypeNumberPad;
    self.phoneNumber.clearButtonMode=UITextFieldViewModeAlways;
    self.phoneNumber.delegate=self;
    //密码
    self.password=[self creatTextFieldWithFrame:CGRectMake(35, 60, SCREEN_WIDTH-70, 40) placeHolder:@" 密码" headeImage:@"Password button"];
    self.password.delegate=self;
    self.password.secureTextEntry=YES;
   // NSLog(@"%@",NSStringFromCGRect(self.password.frame));

    //loginBtn
    UIButton *loginBtn =[[UIButton alloc]initWithFrame:CGRectMake(60, 140, SCREEN_WIDTH-120, 50)];
    [loginBtn setImage:[UIImage imageNamed:@"The login button"] forState:UIControlStateNormal];
    [loginBtn setImage:[UIImage imageNamed:@"The login button"] forState:UIControlStateDisabled];
    [loginBtn addTarget:self action:@selector(loginBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:loginBtn];
    //loginBtn.enabled=NO;
    //registBtn
    UIButton *registBtn =[[UIButton alloc]initWithFrame:CGRectMake(60, 210, 50, 40)];
    registBtn.backgroundColor=[UIColor clearColor];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:registBtn];
    //forgetBtn
    UIButton *forgetBtn =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60-100, 210, 100, 40)];
    forgetBtn.backgroundColor=[UIColor clearColor];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [back addSubview:forgetBtn];
    
    CGFloat backY =CGRectGetMaxY(registBtn.frame);
    back.frame=CGRectMake(0, 0, SCREEN_WIDTH, backY);
    back.center=self.view.center;
    [self.view addSubview:back];
}
-(void)registBtnOnClick:(UIButton *)sender{
    SwichRegistController *swich =[[SwichRegistController alloc]init];
    [self presentViewController:swich animated:YES completion:^{
        
    }];
}
-(void)loginBtnOnClick:(UIButton *)sender{
    [self.view endEditing:YES];
    if (self.phoneNumber.text.length!=11||self.password.text.length<4) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请正确填写用户名和密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [self login];
    }
}
-(void)login{
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText =@"正在登陆";
    NSString *u =self.phoneNumber.text;
    NSString *p = self.password.text;
    NSString *loginString = [NSString stringWithFormat:@"%@:%@",u,p];
    NSData *loginData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64LoginString =[NSString stringWithFormat:@"Basic %@",[loginData base64EncodedStringWithOptions:0]];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    //[manager.requestSerializer setValue:(NSString *)base64LoginString forHTTPHeaderField:@"Authorization"];
       AFHTTPRequestOperation *opration = [manager GET:@"http://112.80.40.185/wp-json/users/me" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        id result =responseObject;
        NSLog(@"%@",result);
           [hud hide:YES];
           
           //保存用户信息
           [UserManeger saveUserLoginInfo:result baseKey:base64LoginString];
           //跳转
           [self performSelector:@selector(swichVC) withObject:nil afterDelay:0.5];
           

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [hud hide:YES];
        id result =operation.responseObject;
        NSLog(@"%@",result);
        [hud hide:YES];
        if (result) {
            if ([result[0] valueForKey:@"message"]!=[NSNull null]) {
                UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"账号或者密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            }
        }else{
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网路" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }

       

    }];

    
    [opration setRedirectResponseBlock:^NSURLRequest * _Nonnull(NSURLConnection * _Nonnull connection, NSURLRequest * _Nonnull request, NSURLResponse * _Nonnull redirectResponse) {
        
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        NSString *value =base64LoginString;
        [mutableRequest addValue:value forHTTPHeaderField:@"Authorization"];
        request =[mutableRequest copy];
        return request;
    }];
    

    
    
    
}


//假延迟  模拟网路
-(void)swichVC{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [UIApplication sharedApplication].keyWindow.rootViewController=[[AppDelegate alloc]init].tabBarController;
}
-(UITextField *)creatTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder headeImage:(NSString *)imageName{
    CGFloat pointX =frame.origin.x;
    CGFloat pointY =frame.origin.y;
    UIView *back =[[UIView alloc]initWithFrame:CGRectMake(pointX, pointY, SCREEN_WIDTH-2*pointX, 40)];
    back.backgroundColor=[UIColor clearColor];
    [self.back addSubview:back];
    //icon
    UIImageView *icon =[[UIImageView alloc]initWithFrame:CGRectMake(3, 5, 18, 25)];
    
    icon.image=[UIImage imageNamed:imageName];
    [back addSubview:icon];
    //line
    UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 37, back.frame.size.width, 1.5)];
    line.backgroundColor=[UIColor whiteColor];
    [back addSubview:line];
    //textfiled
    UITextField *phoneNumber =[[UITextField alloc]initWithFrame:CGRectMake(44, 5,back.frame.size.width-50 , 30)];
    phoneNumber.placeholder=placeHolder;
    phoneNumber.font=[UIFont systemFontOfSize:15];
    [phoneNumber setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    phoneNumber.tintColor=[UIColor whiteColor];
    [back addSubview:phoneNumber];
    return phoneNumber;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGFloat ty =SCREEN_HEIGHT/480*20;
    [UIView animateWithDuration:0.3 animations:^{
        self.back.transform=CGAffineTransformMakeTranslation(0, -ty);
    }];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.isShow) {
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.back.transform=CGAffineTransformIdentity;
        }];
    }
    
}
-(void)tap:(UIGestureRecognizer *)sender{
    [self.view endEditing:YES];
}
-(void)keyboardStadus{
    //show
    self.isShow=YES;
}
-(void)keyboardStadusHide{
    self.isShow=NO;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}
@end

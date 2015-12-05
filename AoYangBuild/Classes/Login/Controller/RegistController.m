//
//  RegistController.m
//  AoYangBuild
//
//  Created by wl on 15/10/19.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "RegistController.h"
#import "RegisterApi.h"
#import "UserManeger.h"
#import "AppDelegate.h"
#import "LoginController.h"


@interface RegistController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIView *cover;
@property(nonatomic,strong)UITextField *phoneNumber;
@property(nonatomic,strong)UITextField *verification;//昵称
@property(nonatomic,strong)UITextField *password;
@property(nonatomic,strong)UITextField *sure_password;


@property(nonatomic,strong)UIButton *regist;
//@property(nonatomic,strong)UIButton *getverificaton;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)BOOL isShow;

@end

@implementation RegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    [self setUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardStadus) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardStadusHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)setUI{
    UIView *cover =[[UIView alloc]init];
    self.cover=cover;
    cover.backgroundColor=[UIColor clearColor];
    //phoneNumber
    self.phoneNumber = [self creatTextFieldWithFrame:CGRectMake(35, 0, SCREEN_WIDTH-70, 40) placeHolder:@" 输入手机号" headeImage:@"Enter a phone number button"];
    self.phoneNumber.keyboardType =UIKeyboardTypeNumberPad;
    self.phoneNumber.clearButtonMode=UITextFieldViewModeAlways;
    self.phoneNumber.delegate=self;
    // NSLog(@"%@",NSStringFromCGRect(self.phoneNumber.frame));
    
    //verification
    self.verification=[self creatTextFieldWithFrame:CGRectMake(35, 60, SCREEN_WIDTH-70, 40) placeHolder:@" 昵称(2-6个字符)" headeImage:@"Verification code button"];
    CGRect frame =self.verification.frame;
    CGFloat verWith=self.verification.frame.size.width;
    self.verification.frame=CGRectMake(frame.origin.x,frame.origin.y, verWith/3*2, frame.size.height);
    self.verification.keyboardType =UIKeyboardTypeDefault;
    self.verification.delegate=self;
    //get verification
//    UIButton *getVerificatin =[[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.verification.frame), 65, verWith/3, 25)];
//    [getVerificatin setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
//    [getVerificatin setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]] forState:UIControlStateDisabled];
//    [getVerificatin setTitleColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.6] forState:UIControlStateNormal];
//    [getVerificatin setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
//    [getVerificatin setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [getVerificatin setTitle:@"60S后重试" forState:UIControlStateDisabled];
//    getVerificatin.layer.cornerRadius=8;
//    getVerificatin.layer.masksToBounds=YES;
//    getVerificatin.titleLabel.font=[UIFont systemFontOfSize:14];
//    CGFloat getWW =getVerificatin.frame.size.width;
//    getVerificatin.frame=CGRectMake(SCREEN_WIDTH-35-getWW-10, getVerificatin.frame.origin.y, getWW+10, getVerificatin.frame.size.height);
//    [getVerificatin addTarget:self action:@selector(getverificationBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.getverificaton=getVerificatin;
//    [self.cover addSubview:getVerificatin];
    
    
    //password
    self.password=[self creatTextFieldWithFrame:CGRectMake(35, 120, SCREEN_WIDTH-70, 40) placeHolder:@" 密码" headeImage:@"Password button"];
    self.password.secureTextEntry=YES;
    self.password.delegate=self;
    
    //sure_password
     self.sure_password=[self creatTextFieldWithFrame:CGRectMake(35, 180, SCREEN_WIDTH-70, 40) placeHolder:@" 确认密码" headeImage:@"Password button"];
    self.sure_password.delegate=self;
    self.sure_password.secureTextEntry=YES;
    
    //registBtn
    UIButton *regist =[[UIButton alloc]initWithFrame:CGRectMake(50, 240+SCREEN_HEIGHT/480*40, SCREEN_WIDTH-100, 50)];
    [regist setImage:[UIImage imageNamed:@"Sign up selected button    Copy"] forState:UIControlStateNormal];
    self.regist=regist;
    [regist addTarget:self action:@selector(registBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.cover addSubview:regist];
    
    //negotiate
    CGFloat negotiateY =CGRectGetMaxY(regist.frame);
    UILabel *negotiate =[[UILabel alloc]init];//WithFrame:CGRectMake(0, negotiateY+10, SCREEN_WIDTH, 20)];
    negotiate.font=[UIFont systemFontOfSize:14];
    negotiate.textColor=[UIColor whiteColor];
    negotiate.textAlignment=NSTextAlignmentCenter;
    negotiate.text=@"我已阅读并同意用户隐私条款";
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:negotiate.font,NSFontAttributeName, nil];
    CGSize textSize= [negotiate.text boundingRectWithSize:CGSizeMake(270,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:Nil].size;
    negotiate.frame=CGRectMake((SCREEN_WIDTH-textSize.width)/2, negotiateY+10, textSize.width, 20);
    [self.cover addSubview:negotiate];
    CGFloat XX =CGRectGetMinX(negotiate.frame);
    UIButton *select =[[UIButton alloc]initWithFrame:CGRectMake(XX-22, negotiateY+10, 18, 18)];
    [select setImage:[UIImage imageNamed:@"Uncheck button"] forState:UIControlStateNormal];
    [select setImage:[UIImage imageNamed:@"Select the button"] forState:UIControlStateSelected];
    [select addTarget:self action:@selector(selectBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    select.selected=YES;
    [self.cover addSubview:select];
    
    CGFloat yy =CGRectGetMaxY(select.frame);
    self.cover.frame=CGRectMake(0, 0, SCREEN_WIDTH, yy);
    self.cover.center=self.view.center;
    [self.view addSubview:self.cover];
    
    
    //cancelBtn
    UIButton *cancel =[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20-25, 30, 25, 25)];
    [cancel setBackgroundImage:[UIImage imageNamed:@"Exit button"] forState:UIControlStateNormal];
    cancel.tag=104;
    [cancel addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];

}
-(void)btnOnClick:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(UITextField *)creatTextFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder headeImage:(NSString *)imageName{
    CGFloat pointX =frame.origin.x;
    CGFloat pointY =frame.origin.y;
    UIView *back =[[UIView alloc]initWithFrame:CGRectMake(pointX, pointY, SCREEN_WIDTH-2*pointX, 40)];
    back.backgroundColor=[UIColor clearColor];
    [self.cover addSubview:back];
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
   // phoneNumber.keyboardType=UIKeyboardTypeASCIICapable;
    return phoneNumber;
}
-(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark ----All  btn onClick---
//-(void)getverificationBtnOnClick:(UIButton *)sender{
//    sender.enabled=NO;
//    [self.getverificaton setTitle:@"60S后重试" forState:UIControlStateDisabled];
//    NSTimer *timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refersh) userInfo:nil repeats:YES];
//    self.timer=timer;
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//}
//-(void)refersh{
//    NSInteger second =[[self.getverificaton.currentTitle substringToIndex:2]integerValue];
//    second--;
//    [self.getverificaton setTitle:[NSString stringWithFormat:@"%ldS后重试",(long)second] forState:UIControlStateDisabled];
//    if (second==0) {
//        [self.timer invalidate];
//        self.getverificaton.enabled=YES;
//    }
//}
-(void)registBtnOnClick:(UIButton *)sender{
    if (self.phoneNumber.text.length!=11||self.verification.text.length<2||self.verification.text.length>6||!self.password.text||!self.sure_password.text) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请完善注册信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if (self.password.text.length<4){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"密码过于简单" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if (![self.password.text isEqualToString:self.sure_password.text]){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"确认密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

    }else if([self isHaveIllegalChar:self.verification.text]){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"昵称含有非法字符" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if(![self isHaveIllegalPhoneNumber:self.phoneNumber.text]){
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"请正确输入手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];

    }else{
        //达到要求 ->去注册
        [self register];
    }
    
    
}
-(void)register{
    //data[role] ->注册类型  subscriber个人注册  企业注册contributor
    NSString *type ;
    BOOL company;
    if(self.type==RegisterTypeSub){
         type =@"subscriber";
         company=NO;
    }else if (self.type==RegisterTypeCompany){
        type =@"contributor";
        company=YES;
    }
    //手机号data[user_login]  昵称data[nickname]  密码data[user_pass]
    NSDictionary *param =@{@"data[user_login]":self.phoneNumber.text,@"data[nickname]":self.verification.text,@"data[user_pass]":self.password.text,@"data[role]":type,@"data[display_name]":self.verification.text};
    RegisterApi *api =[[RegisterApi alloc]initWithParam:param];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        id result = [request responseJSONObject];
//        //保存用户信息
//        UserManeger *maneger =[[UserManeger alloc]init];
//        [maneger saveUserName:self.phoneNumber.text andPassWord:self.password.text company:company];
        
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        [self performSelector:@selector(backTologin) withObject:nil afterDelay:2.0f];
        
    } failure:^(YTKBaseRequest *request) {
        id result = [request responseJSONObject];
        if([[result[0] valueForKey:@"message"] isEqualToString:@"Username already exists"]){
            [SVProgressHUD showErrorWithStatus:@"用户名已经存在"];}else{
                [SVProgressHUD showErrorWithStatus:@"注册失败"];
            }
        NSLog(@"%@",result);

    }];
}
-(void)backTologin{
    LoginController *loginVC =[[LoginController alloc]init];
    [[[UIApplication sharedApplication] delegate]window].rootViewController = loginVC;
    
}
-(void)selectBtnOnClick:(UIButton *)sender{
    sender.selected=!sender.selected;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    CGFloat ty =SCREEN_HEIGHT/480*20;
    
    if (textField==self.phoneNumber) {
        
    }else if (textField==self.verification){
        ty=2*ty;
    }else if (textField==self.password){
        ty=3*ty;
    }else if (textField==self.sure_password){
        ty=4*ty;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.transform=CGAffineTransformMakeTranslation(0, -ty);
        
    }];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.isShow) {
        
    }else{
    [UIView animateWithDuration:0.3 animations:^{
        self.cover.transform=CGAffineTransformIdentity;
    }];
    }
}
- (BOOL)isHaveIllegalChar:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location<str.length;
}
-(BOOL)isHaveIllegalPhoneNumber:(NSString *)text{
    NSString *regex = @"((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [predicate evaluateWithObject:text];
    return isMatch;
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

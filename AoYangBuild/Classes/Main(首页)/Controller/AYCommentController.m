//
//  AYCommentController.m
//  AoYangBuild
//
//  Created by wl on 15/10/22.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYCommentController.h"
#import "NewsApi.h"
#import "ContentModel.h"
#import "contentFrameModel.h"
#import <MBProgressHUD.h>
#import "ContentCell.h"

@interface AYCommentController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UITextField *textfield;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)UILabel *nothingLab;

@end

@implementation AYCommentController{
    NSArray *_commentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64)];
        _tableView.backgroundColor=[UIColor whiteColor];
        _tableView.tableFooterView=[[UIView alloc]init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
-(void)setUI{
    self.title=@"新闻评论";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //contentView评论
    self.contentView=[[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49-64, SCREEN_WIDTH, 49)];
    [self.contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Comment box"]]];
    UITextField *textField =[[UITextField alloc]initWithFrame:CGRectMake(10, 6, SCREEN_WIDTH-20, 37)];
    UIView *leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 37)];
    textField.leftView=leftView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    textField.placeholder=@"写评论...";
    textField.font=[UIFont systemFontOfSize:15];
    textField.delegate=self;
    [textField setBackground:[UIImage imageNamed:@"Comment"]];
    textField.returnKeyType =UIReturnKeySend;
    self.textfield=textField;
    [self.contentView addSubview:self.textfield];
    
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentTableViewTouchInSide)];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tableViewGesture];
    [self.view addSubview:self.contentView];
    
    UILabel *nothingLab =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    nothingLab.textAlignment=NSTextAlignmentCenter;
    nothingLab.textColor=[UIColor lightGrayColor];
    nothingLab.text=@"暂无评论数据";
    [self.tableView addSubview:nothingLab];
    nothingLab.center =self.tableView.center;
    nothingLab.hidden=YES;
    self.nothingLab =nothingLab;
    [self loadComment];
    
}
-(void)loadComment{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NewsApi *api =[[NewsApi alloc]initWithComment:nil andNewsID:self.ID];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        NSArray *resultArray =[request responseJSONObject];
        if (resultArray.count==0) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            self.nothingLab.hidden=NO;
        }
        NSMutableArray *arrM =[NSMutableArray array];
        for (int i=0; i<resultArray.count; i++) {
            NSDictionary *dic =resultArray[i];
            ContentModel *model =[ContentModel contentModelWithDic:dic];
            contentFrameModel *frameModel =[[contentFrameModel alloc]init];
            frameModel.model=model;
            [arrM addObject:frameModel];
        }
        _commentArray =arrM;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.tableView reloadData];
    } failure:^(YTKBaseRequest *request) {
        id result =[request responseJSONObject];
        NSLog(@"%@",result);
        
    }];
}

#pragma mark textFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length!=0) {
        [self.view endEditing:YES];
        MBProgressHUD *HUD =[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.labelText=@"更新评论...";
        NewsApi *api =[[NewsApi alloc]initWithComment:textField.text andNewsID:self.ID];
        textField.text=@"";
        [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
            id result =[request responseJSONObject];
            [self loadComment];
            NSLog(@"%@",result);
        } failure:^(YTKBaseRequest *request) {
            id result =[request responseJSONObject];
            [HUD hide:YES];
            NSLog(@"%@",result);
        }];
    }
    return YES;
}
#pragma mark keyboard show and hide
-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary* userInfo = [notification userInfo];
    
    NSTimeInterval animationDuration;
    
    UIViewAnimationCurve animationCurve;
    
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    int yy = keyboardRect.origin.y;
    CGRect  frame = self.contentView.frame;
    frame.origin.y=yy-49-64;
    
    [UIView beginAnimations:nil context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    [UIView setAnimationCurve:animationCurve];
    
    self.contentView.frame=frame;
    
    [UIView commitAnimations];
    
    
}

- (void)commentTableViewTouchInSide{
    [self.textfield resignFirstResponder];
}

#pragma mark tableView delegate and datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commentArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_commentArray.count==0) {
        return indexPath.section==0?40:0;
    }
    contentFrameModel *modelF = _commentArray[indexPath.row];
    return modelF.cellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0) {
//        NSString *ID =@"web_cell";
//        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ID];
//        if (!cell) {
//            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//            //[cell.contentView addSubview:self.webView];
//            UIView *back =[[UIView alloc]init];
//            UIView *line =[[UIView alloc]initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
//            line.backgroundColor=[UIColor grayColor];
//            line.alpha=0.4;
//            UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(20, 2, SCREEN_WIDTH-40, 40)];
//            lab.text=@"评论";
//            lab.textColor=appColor;
//            [back addSubview:line];
//            [back addSubview:lab];
//            [cell.contentView addSubview:back];
//        }
//        return cell;
//    }else if (indexPath.section==1){
        NSString *ID =@"content_cell";
        ContentCell *cell =[ContentCell cellWithTableView:tableView identifier:ID];
        contentFrameModel *frameModel =_commentArray[indexPath.row];
        cell.frameModel=frameModel;
        return cell;
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end

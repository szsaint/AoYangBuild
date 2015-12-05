//
//  AYArticleDetailController.m
//  AoYangBuild
//
//  Created by wl on 15/10/22.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYArticleDetailController.h"
#import "AYCommentController.h"
#import <MBProgressHUD.h>

@interface AYArticleDetailController ()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation AYArticleDetailController

-(UIWebView *)webView{
    if (!_webView) {
        _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _webView.backgroundColor=[UIColor whiteColor];
        _webView.delegate=self;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
-(void)loadData{
    //NSString *htmlPath =[[NSBundle mainBundle]pathForResource:@"html" ofType:nil];
    NSString *htmlApp =@"<head><meta name=\"viewport\" content=\"width=device-width\"><style>img{max-width:100% !important;height:auto;}p,html,body{margin:0;padding:0}body{padding:0 6px}</style></head>";//[NSString stringWithContentsOfFile:htmlPath usedEncoding:nil error:nil];
    NSString *content =self.detailDic[@"content"];
    NSString *title =[NSString stringWithFormat:@"<h4 style=\"text-align:center\">%@</h4>",self.detailDic[@"title"]];//<div class=\"title\">%@</div>
    if (!content) {
        return;
    }
    NSMutableString *html = [NSMutableString stringWithString:htmlApp];
    [html appendString:title];
    [html appendString:content];
    [self.webView loadHTMLString:html baseURL:nil];
    
    
}

-(void)setUI{
    self.title=@"文章详情";
    
    UIButton *commentCount =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [commentCount setTitle:@"评论" forState:UIControlStateNormal];
    [commentCount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentCount addTarget:self action:@selector(commentBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc ]initWithCustomView:commentCount];
    
    //webView
    [self.view addSubview:self.webView];
    [self loadData];
    
    
}

-(void)commentBtnOnClick:(UIButton *)sender{
    AYCommentController *conmentVC =[[AYCommentController alloc]init];
    conmentVC.ID =self.detailDic[@"ID"];
    [self.navigationController pushViewController:conmentVC animated:YES];
}
#pragma mark webView delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

@end

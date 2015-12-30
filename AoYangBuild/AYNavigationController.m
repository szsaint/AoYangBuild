//
//  AYNavigationController.m
//  AoYangBuild
//
//  Created by wl on 15/11/5.
//  Copyright © 2015年 saint. All rights reserved.
//

#import "AYNavigationController.h"

@interface AYNavigationController ()

@end

@implementation AYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor],NSForegroundColorAttributeName,
                                               nil];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"Top navigation bar"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc]init]];
    
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [self.navigationBar setTranslucent:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
        if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setTitle:@"返回" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"chevron left"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"chevron left"] forState:UIControlStateHighlighted];
            button.frame =CGRectMake(0, 0, 30, 24);
            // 让按钮内部的所有内容左对齐
//            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            //        [button sizeToFit];
            // 让按钮的内容往左边偏移10
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            [button addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
            
            // 修改导航栏左边的item
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
            
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = YES;
        }
        
        // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
        // 意思是，我们任然可以重新在push控制器的viewDidLoad方法中设置导航栏的leftBarButtonItem，如果设置了就会覆盖在push方法中设置的“返回”按钮，因为 [super push....]会加载push的控制器执行viewDidLoad方法。
        [super pushViewController:viewController animated:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

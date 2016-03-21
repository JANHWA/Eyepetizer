//
//  RankViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "RankViewController.h"
#import "WRankViewController.h"
#import "MRankViewController.h"
#import "TRankViewController.h"

@interface RankViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>
{
    UIPageViewController *_pageViewController;
    NSMutableArray *_vcArray;
    UIButton *_wButton;
    UIButton *_mButton;
    UIButton *_tButton;
    
}

@property(nonatomic, assign) NSInteger currentPage;

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    _vcArray = [[NSMutableArray alloc] init];
    [self configUI];
}
- (void)configUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    KWS(ws);
    _wButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_wButton setTitle:@"周排行" forState:UIControlStateNormal];
    [_wButton setBackgroundColor:[UIColor whiteColor]];
    [_wButton setTitleColor:[UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1] forState:UIControlStateNormal];
    [_wButton setTitleColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1] forState:UIControlStateSelected];
    [self.view addSubview:_wButton];
    [_wButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top).offset(64);
        make.left.equalTo(ws.view.mas_left).offset(0);
        make.height.equalTo(@30);
        make.width.equalTo(@(kScreenWidth/3));
    }];
    _mButton = [[UIButton alloc] init];
    [_mButton setTitle:@"月排行" forState:UIControlStateNormal];
    [_mButton setBackgroundColor:[UIColor whiteColor]];
    [_mButton setTitleColor:[UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1] forState:UIControlStateNormal];
    [_mButton setTitleColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1] forState:UIControlStateSelected];
    [self.view addSubview:_mButton];
    [_mButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top).offset(64);
        make.left.equalTo(_wButton.mas_right).offset(0);
        make.height.equalTo(@30);
        make.width.equalTo(@(kScreenWidth/3));
    }];
    _tButton = [[UIButton alloc] init];
    [_tButton setTitle:@"总排行" forState:UIControlStateNormal];
    [_tButton setBackgroundColor:[UIColor whiteColor]];
    [_tButton setTitleColor:[UIColor colorWithRed:0.21 green:0.21 blue:0.21 alpha:1] forState:UIControlStateNormal];
    [_tButton setTitleColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1] forState:UIControlStateSelected];
    [self.view addSubview:_tButton];
    [_tButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top).offset(64);
        make.left.equalTo(_mButton.mas_right).offset(0);
        make.height.equalTo(@30);
        make.width.equalTo(@(kScreenWidth/3));
    }];
    
    // 创建pageViewController的页面视图
    NSArray *className = @[@"WRankViewController",@"MRankViewController",@"TRankViewController"];
    for (NSInteger i = 0; i < className.count; i++) {
        Class class = NSClassFromString(className[i]);
        [_vcArray addObject:[[class alloc] init]];
    }
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle: UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    [_pageViewController setViewControllers:@[_vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
    }];
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    _pageViewController.view.frame = CGRectMake(0, 94, kScreenWidth, kScreenHeight - 94 - 44);
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    self.currentPage = 0;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [_vcArray indexOfObject:viewController];
    // 当前页是最后一页的时候返回nil
    if (index == _vcArray.count - 1) {
        return nil;
    }
    // 如果不是最后一页,返回数组中的下一个视图
    return _vcArray[index + 1];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [_vcArray indexOfObject:viewController];
    // 如果当前页是第0页,返回nil
    if (index == 0) {
        return nil;
    }
    // else 返回数组中上一个视图
    return _vcArray[index - 1];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

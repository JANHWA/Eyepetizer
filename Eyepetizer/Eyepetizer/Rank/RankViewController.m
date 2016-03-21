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
    _wButton.tag = 100;
    [_wButton setTitle:@"周排行" forState:UIControlStateNormal];
    [_wButton setBackgroundColor:[UIColor whiteColor]];
    [_wButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_wButton setTitleColor:[UIColor colorWithWhite:0.324 alpha:1.000] forState:UIControlStateNormal];
    [_wButton setTitleColor:[UIColor colorWithWhite:0.629 alpha:1.000] forState:UIControlStateSelected];
    [self.view addSubview:_wButton];
    [_wButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top).offset(64);
        make.left.equalTo(ws.view.mas_left).offset(0);
        make.height.equalTo(@30);
        make.width.equalTo(@(kScreenWidth/3));
    }];
    _mButton = [[UIButton alloc] init];
    _mButton.tag = 101;
    [_mButton setTitle:@"月排行" forState:UIControlStateNormal];
    [_mButton setBackgroundColor:[UIColor whiteColor]];
    [_mButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_mButton setTitleColor:[UIColor colorWithWhite:0.324 alpha:1.000] forState:UIControlStateNormal];
    [_mButton setTitleColor:[UIColor colorWithWhite:0.629 alpha:1.000] forState:UIControlStateSelected];
    [self.view addSubview:_mButton];
    [_mButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top).offset(64);
        make.left.equalTo(_wButton.mas_right).offset(0);
        make.height.equalTo(@30);
        make.width.equalTo(@(kScreenWidth/3));
    }];
    _tButton = [[UIButton alloc] init];
    _tButton.tag = 102;
    [_tButton setTitle:@"总排行" forState:UIControlStateNormal];
    [_tButton setBackgroundColor:[UIColor whiteColor]];
    [_tButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tButton setTitleColor:[UIColor colorWithWhite:0.324 alpha:1.000] forState:UIControlStateNormal];
    [_tButton setTitleColor:[UIColor colorWithWhite:0.629 alpha:1.000] forState:UIControlStateSelected];
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
- (void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    for (NSInteger i = 0; i <3; i++) {
        UIButton *button = [self.view viewWithTag:100+i];
        if (i == currentPage) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
}
- (void)btnClick:(UIButton *)btn
{
    NSInteger index = btn.tag - 100;
    
    [_pageViewController setViewControllers:@[_vcArray[index]] direction:index < _currentPage animated:YES completion:^(BOOL finished) {
    }];
    self.currentPage = index;
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

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    // pageViewController.viewControllers[0] 当前视图在次数组中第0个位置
    UIViewController *vc = pageViewController.viewControllers[0];
    self.currentPage = [_vcArray indexOfObject:vc];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

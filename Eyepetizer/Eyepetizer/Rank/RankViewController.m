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
#import "JHRootPageView.h"

@interface RankViewController ()

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    
    self.view.backgroundColor =[UIColor whiteColor];
    NSArray *vcArray = @[@"WRankViewController",@"MRankViewController",@"TRankViewController"];
    NSArray *title   = @[@"周排行",@"月排行",@"总排行"];
    JHRootPageView *pageView = [[JHRootPageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 49)
                                                         controllers:vcArray
                                                               title:title
                                                                type:YES
                                                       addController:self
                                                           btnHeight:25
                                                      btnNormalColor:[UIColor grayColor]
                                                      btnSelectcolor:[UIColor blackColor]];
    [self.view addSubview:pageView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

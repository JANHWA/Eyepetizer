//
//  RootViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    [self loadData];
    [self configUI];
}

- (void)configUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_top"] forBarMetrics:UIBarMetricsCompact];
    
}

- (void)loadData
{
    NSLog(@"子类需要重写loadData");
}

#pragma mark - tableView协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"子类需要重写numberOfRowsInSection");
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"子类需要重写heightForRowAtIndexPath");
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"子类需要重写cellForRowAtIndexPath");
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"子类需要重写didSelectRowAtIndexPath");
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(JHTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CATransform3D rotation;//3D旋转
    
    rotation = CATransform3DMakeTranslation(0 ,50 ,20);
    rotation = CATransform3DScale(rotation, 0.9, .9, 1);
    
    rotation.m34 = 1.0/ -600;
    
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    
    [UIView beginAnimations:@"rotation" context:NULL];
    //旋转时间
    [UIView setAnimationDuration:1];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
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

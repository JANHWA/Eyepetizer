//
//  TRankViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "TRankViewController.h"
#import "TRankModel.h"

@interface TRankViewController ()

@end

@implementation TRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor                 = [UIColor colorWithRed:0.99 green:0.91 blue:0.71 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)configUI
{
    [super configUI];
    [self customBackButton];
    [super configUI];
    [self customBackButton];
    _tableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44-84) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [header setTitle:@"OOH LA LA..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.header = header;
    [_tableView.header beginRefreshing];
    [_tableView registerClass:[JHTableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (void)loadData
{
    [TRankModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"my_description":@"description",@"feed":@"cover.feed",@"blurred":@"cover.blurred"};
    }];
    [[CHNetWorking shareManager] requestData:kAllRank parameters:nil sucBlock:^(id responseObject) {
        [_tableView.header endRefreshing];
        if (_dataArray != nil) {
            [_dataArray removeAllObjects];
        }
    NSArray *array                            = responseObject[@"itemList"];
        for (NSDictionary *dict in array) {
    TRankModel *model                         = [TRankModel mj_objectWithKeyValues:dict[@"data"]];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failureBlock:^{

    }];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIde                  = @"cell";
    JHTableViewCell *cell                     = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
    cell                                      = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
    }
    TRankModel *model                         = _dataArray[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.feed]];
    cell.titleL.text                          = model.title;
    cell.cWithTL.text                         = [NSString stringWithFormat:@"#%@  / %@\"",model.category,model.duration];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DetailViewController *detail              = [[DetailViewController alloc] init];
    TRankModel *model                         = _dataArray[indexPath.row];

    detail.detailTitle                        = model.title;
    detail.detailCategory                     = model.category;
    detail.detailPlayUrl                      = model.playUrl;
    detail.detailDuration                     = model.duration;
    detail.detailCoverBlurred                 = model.blurred;
    detail.detailCoverForFeed                 = model.feed;
    detail.detailDescription                  = model.my_description;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)customBackButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setBackgroundImage:[UIImage imageNamed:@"back@2x"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    
}

- (void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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

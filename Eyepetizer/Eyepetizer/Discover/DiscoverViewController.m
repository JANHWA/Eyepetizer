//
//  DiscoverViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "DiscoverViewController.h"
#import "JHCollectionViewCell.h"
#import "DiscoverModel.h"
#import "ListViewController.h"


@interface DiscoverViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
}

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestData];
    [self configUI];
}

- (void)requestData
{
    [[CHNetWorking shareManager] requestData:kDiscover parameters:nil sucBlock:^(id responseObject) {
        NSArray *array = [DiscoverModel arrayOfModelsFromDictionaries:responseObject];
        [_collectionView.header endRefreshing];
        if (_dataArray != nil) {
            [_dataArray removeAllObjects];
        }
        [_dataArray addObjectsFromArray:array];
        [_collectionView reloadData];
        
    } failureBlock:^{
        
    }];
}

- (void)configUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *flowLayout    = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection                = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing             = 3;
    flowLayout.minimumInteritemSpacing        = 4;

    _collectionView                           = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 44) collectionViewLayout:flowLayout];
    _collectionView.delegate                  = self;
    _collectionView.dataSource                = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[JHCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [header setTitle:@"你微笑时好美" forState:MJRefreshStatePulling];
    [header setTitle:@"OOH LA LA..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    _collectionView.header = header;
    [_collectionView.header beginRefreshing];
    [self.view addSubview:_collectionView];
}

#pragma mark -UICollectionView协议方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth-4)*0.5, (kScreenWidth-4)*0.5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId    = @"cell";
    JHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    DiscoverModel *model       = _dataArray[indexPath.item];
    [cell.bgImage sd_setImageWithURL:[NSURL URLWithString:model.bgPicture]];
    cell.title.text            = model.name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListViewController *vc = [[ListViewController alloc] init];
    vc.url                 = [_dataArray[indexPath.item] name];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [_collectionView deselectItemAtIndexPath:indexPath animated:YES];
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

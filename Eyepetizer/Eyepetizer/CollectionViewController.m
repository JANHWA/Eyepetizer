//
//  ControllerViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "CollectionViewController.h"
#import "JHTableViewCell.h"


@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIImageView *_bgImage;
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)configUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createBgImage];
    _tableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-44-64) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[JHTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)createBgImage
{
    KWS(ws);
    _bgImage = [[UIImageView alloc] init];
    _bgImage.image = [UIImage imageNamed:@"nothing"];
    [self.view addSubview:_bgImage];
    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view.mas_centerX);
        make.centerY.equalTo(ws.view.mas_centerY);
        make.width.mas_equalTo(kScreenHeight*(9.0/16.0));
        make.height.mas_equalTo(kScreenWidth);
    }];
    
}

/**
 *    加载存储在本地的数据
 */
- (void)loadData
{
    _dataArray = [[CollectModel MR_findAll] mutableCopy];
    [_tableView reloadData];
    
}
/**
 *  Cell的编辑style
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIde = @"cell";
    JHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIde forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail   = [[DetailViewController alloc] init];
    ChoicModel *model              = _dataArray[indexPath.row];
    detail.detailTitle             = model.title;
    detail.detailCategory          = model.category;
    detail.detailPlayUrl           = model.playUrl;
    detail.detailDuration          = model.duration;
    detail.detailCoverBlurred      = model.coverBlurred;
    detail.detailCoverForFeed      = model.coverForFeed;
    detail.detailDescription       = model.my_description;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self prompt:(NSIndexPath *)indexPath];
    
}

- (void)prompt:(NSIndexPath *)indexPath
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"取消收藏" message:@"确认取消收藏?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    // 单击YES按钮执行的代码块
    [alert addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deletWithModel:_dataArray[indexPath.row]];

    }]];
    // 让提示显示
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)deletWithModel:(CollectModel *)model
{
    // 从数据库中删除
    [model MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    // 拿到model的位置
    NSInteger num = [_dataArray indexOfObject:model];
    // 从数组中删除
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:num inSection:0];
    [_dataArray removeObjectAtIndex:indexPath.row];
    // 从_tableView删除Cell
    if (_dataArray.count == 0) {
        [self.view bringSubviewToFront:_bgImage];
        _bgImage.alpha = 1;
    }else{
        _bgImage.alpha = 0;
    }
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [_dataArray removeObjectAtIndex:sourceIndexPath.row];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _dataArray = [[CollectModel MR_findAll] mutableCopy];
    [_tableView reloadData];
    if (_dataArray.count == 0) {
        [self.view bringSubviewToFront:_bgImage];
        _bgImage.alpha = 1;
    }else{
        _bgImage.alpha = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

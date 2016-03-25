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

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}
- (void)configUI
{
    
//    [self customButton:@"back" withLocation:YES];
    self.automaticallyAdjustsScrollViewInsets = YES;
    _tableView            = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[JHTableViewCell class] forCellReuseIdentifier:@"cell"];
}

//- (void)backBtnClick
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

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
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //    NSString *str = _dataArray[sourceIndexPath.row];
    [_dataArray removeObjectAtIndex:sourceIndexPath.row];
    //    [_dataArray insertObject:str atIndex:destinationIndexPath.row];
}

- (void)viewWillAppear:(BOOL)animated
{
    _dataArray = [[CollectModel MR_findAll] mutableCopy];
    [_tableView reloadData];
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

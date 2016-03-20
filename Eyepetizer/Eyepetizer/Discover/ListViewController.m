//
//  ListViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "ListViewController.h"
#import "DetailModel.h"
#import "MJExtension.h"
#import "DetailViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configUI
{
    [super configUI];
    [_tableView registerClass:[JHTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)loadData
{
    [DetailModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"my_description":@"description",@"feed":@"cover.feed",@"blurred":@"cover.blurred"};
    }];
    NSString *urlString = [NSString stringWithFormat:kCategory,_url];
    NSString *url       = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[CHNetWorking shareManager] requestData:url parameters:nil sucBlock:^(id responseObject) {
    NSArray *array      = responseObject[@"itemList"];
        for (NSDictionary *dict in array) {
    DetailModel *model  = [DetailModel mj_objectWithKeyValues:dict[@"data"]];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    } failureBlock:^{

    }];
}

#pragma mark - tableView协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIde = @"cell";
    JHTableViewCell *cell    = [tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
    cell                     = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
    }
    DetailModel *model       = _dataArray[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.feed]];
    cell.titleL.text         = model.title;
    cell.cWithTL.text        = [NSString stringWithFormat:@"#%@  / %@\"",model.category,model.duration];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc] init];
    DetailModel *model = _dataArray[indexPath.row];
    
    detail.detailTitle        = model.title;
    detail.detailCategory     = model.category;
    detail.detailPlayUrl      = model.playUrl;
    detail.detailDuration     = model.duration;
    detail.detailCoverBlurred = model.blurred;
    detail.detailCoverForFeed = model.feed;
    detail.detailDescription  = model.my_description;
    
    [self.navigationController pushViewController:detail animated:YES];
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

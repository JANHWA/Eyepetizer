//
//  ChoiceViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "ChoiceViewController.h"
#import "DetailViewController.h"
#import "JHTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ChoiceViewController ()

@end

@implementation ChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)configUI
{
    [super configUI];
    [_tableView registerClass:[JHTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)loadData
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date                   = [[NSDate alloc] init];
    NSString *dateString           = [dateFormatter stringFromDate:date];
    [[CHNetWorking shareManager] requestData:[NSString stringWithFormat:kChoice,dateString] parameters:nil sucBlock:^(id responseObject) {
    NSArray *array                 = responseObject[@"dailyList"];
        for (NSDictionary *dict in array) {
    NSArray *array2                = [ChoicModel arrayOfModelsFromDictionaries:dict[@"videoList"]];
            [_dataArray addObjectsFromArray:array2];
        }
        [_tableView reloadData];
    } failureBlock:^{

    }];
}

#pragma mark - tableView 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 240;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId        = @"cell";
    JHTableViewCell *cell          = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
    cell                           = [[JHTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    ChoicModel *model              = _dataArray[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverForFeed]];
    cell.titleL.text               = model.title;
    cell.cWithTL.text              = [NSString stringWithFormat:@"#%@  / %@\"",model.category,model.duration];
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

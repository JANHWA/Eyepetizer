//
//  ChoiceViewController.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "ChoiceViewController.h"
#import "ChoiceCell.h"

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
    [_tableView registerNib:[UINib nibWithNibName:@"ChoiceCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)loadData
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [[NSDate alloc] init];
    NSString *dateString = [dateFormatter stringFromDate:date];
    [[CHNetWorking shareManager] requestData:[NSString stringWithFormat:kChoice,dateString] parameters:nil sucBlock:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        NSArray *array = responseObject[@"dailyList"];
        for (NSDictionary *dict in array) {
            NSArray *array2 = [ChoicModel arrayOfModelsFromDictionaries:dict[@"videoList"]];
            NSLog(@"+++++%@",dict[@"videoList"]);
            [_dataArray addObjectsFromArray:array2];
        }
        NSLog(@"Count:%ld",_dataArray.count);
        
        [_tableView reloadData];
    } failureBlock:^{
        
    }];
}

#pragma mark - tableView 协议方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    ChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.model = _dataArray[indexPath.row];
    NSLog(@"+++++%@",cell.model);
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(ChoiceCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    SelectionCell *cell = [[SelectionCell alloc] init];
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
    
    //    [cell cellOffset];
    cell.model = _dataArray[indexPath.row];
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

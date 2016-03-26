//
//  RootViewController.h
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

- (void)configUI;

- (void)loadData;

- (void)backBtnClick;

- (void)shareBtnClick:(UIButton *)sender;

- (void)customButton:(NSString *)imageName withLocation:(BOOL)location;

@end

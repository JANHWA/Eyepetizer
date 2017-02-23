//
//  JHDetailView.h
//  Eyepetizer
//
//  Created by Justin on 2017/2/23.
//  Copyright © 2017年 CheeHwa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CollectionBtnBlock)(UIButton *);

@interface JHDetailView : UIView

@property (strong, nonatomic) UILabel *titleLabel;//标题
@property (strong, nonatomic) UILabel *lineLabel;//下划线
@property (strong, nonatomic) UILabel *typeLabel;//分类
@property (strong, nonatomic) UILabel *contentLabel;//内容
@property (strong, nonatomic) UIButton *collectionBtn;//收藏按钮
@property (strong, nonatomic) UIImageView *bgImageV;//背景

@property (copy, nonatomic) CollectionBtnBlock buttonBlock;

- (void)showContentWithDic:(NSDictionary *)dict;

@end

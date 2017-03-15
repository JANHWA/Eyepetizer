//
//  JHDetailView.m
//  Eyepetizer
//
//  Created by Justin on 2017/2/23.
//  Copyright © 2017年 CheeHwa. All rights reserved.
//

#import "JHDetailView.h"

@implementation JHDetailView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initView];
    }
    return self;
}

- (void)initView {
    
    //背景
    self.bgImageV = [[UIImageView alloc] init];
    [self addSubview:self.bgImageV];
    
    for (NSInteger i = 0; i < 4; i++) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        
        if (i == 0) {
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:15.0];
            label.textColor = [UIColor whiteColor];
            self.titleLabel = label;
            self.titleLabel.adjustsFontSizeToFitWidth = YES;
        } else if (i == 1) {
            self.lineLabel = label;
            self.lineLabel.backgroundColor = [UIColor colorWithRed:0.703 green:0.693 blue:0.713 alpha:1.000];
        } else if (i == 2) {
            
            self.typeLabel = label;
            self.typeLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.82 alpha:1];
        } else {
            self.contentLabel = label;
            self.contentLabel.numberOfLines = 0;
            self.contentLabel.font = [UIFont systemFontOfSize:14.0];
            self.contentLabel.textColor = [UIColor colorWithRed:0.798 green:0.797 blue:0.815 alpha:1.000];
            self.contentLabel.shadowColor = [UIColor grayColor];
            self.contentLabel.shadowOffset  = CGSizeMake(0.5, 0.5);
        }
    }
    
    //收藏按钮
    self.collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.collectionBtn];
    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bulletscreen_icon_like"] forState:UIControlStateNormal];
    [self.collectionBtn setBackgroundImage:[UIImage imageNamed:@"bulletscreen_icon_like_"] forState:UIControlStateSelected];
    [self.collectionBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 背景
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    // 标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageV).offset(kScreenHeight * 0.5);
        make.left.equalTo(self.bgImageV).offset(kScreenWidth * 0.035);
        make.right.equalTo(self.bgImageV);
        make.height.mas_equalTo(@(kScreenHeight * 0.035));
    }];
    
    // 收藏按钮
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgImageV.mas_right).offset(-kScreenWidth * 0.04);
        make.width.height.mas_equalTo(30);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-5);
    }];
    
    // 下划线
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(2);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
    }];
    
    // 分类
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.titleLabel);
        make.top.equalTo(self.lineLabel.mas_bottom).offset(kScreenHeight * 0.025);
        make.right.equalTo(self.lineLabel);
    }];
    
    //内容
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(kScreenHeight * 0.03);
        make.left.equalTo(self).offset(kScreenWidth * 0.04);
        make.right.equalTo(self).offset(-kScreenWidth * 0.04);
        make.bottom.equalTo(self);
    }];
    
}

- (void)buttonClick:(UIButton *)sender {
    
    if (_buttonBlock) {
        _buttonBlock(sender);
    }
}

- (void)showContentWithDic:(NSDictionary *)dict {
    
    self.titleLabel.text = dict[@"title"];
    self.typeLabel.text  = [NSString stringWithFormat:@"#%@ / %@\"",dict[@"detailCategory"],dict[@"detailDuration"]];
    self.contentLabel.text = dict[@"detailDescription"];
    [self.bgImageV sd_setImageWithURL:[NSURL URLWithString:dict[@"detailCoverBlurred"]]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  JHCollectionViewCell.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "JHCollectionViewCell.h"
#import "Masonry.h"

@implementation JHCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        KWS(ws);
        // 背景图片
        _bgImage             = [[UIImageView alloc] init];
        _bgImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_bgImage];
        [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView.mas_top).offset(0);
            make.left.equalTo(ws.contentView.mas_left).offset(0);
            make.bottom.equalTo(ws.contentView.mas_bottom).offset(0);
            make.right.equalTo(ws.contentView.mas_right).offset(0);
            make.height.equalTo(ws.mas_width);
        }];
        
         // 添加titleLabel
        _title               = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor     = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        _title.shadowColor   = [UIColor grayColor];
        _title.shadowOffset  = CGSizeMake(0.5, 0.5);
        _title.font          = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:_title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView.mas_top).offset(50);
            make.left.equalTo(ws.contentView.mas_left).offset(0);
            make.bottom.equalTo(ws.contentView.mas_bottom).offset(-50);
            make.right.equalTo(ws.contentView.mas_right).offset(0);
        }];
    }
    return self;
}

@end

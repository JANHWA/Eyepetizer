//
//  JHTableViewCell.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/19.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "JHTableViewCell.h"
#import "Masonry.h"



@implementation JHTableViewCell

- (void)awakeFromNib {
    // Initialization code

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self                   = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        KWS(ws);
        // 初始化背景视图
    _imageV                = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];

        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView.mas_top).offset(0);
            make.left.equalTo(ws.contentView.mas_left).offset(0);
            make.bottom.equalTo(ws.contentView.mas_bottom).offset(0);
            make.right.equalTo(ws.contentView.mas_right).offset(0);
        }];
        // 标题
    _titleL                = [[UILabel alloc] init];
    _titleL.textAlignment  = NSTextAlignmentCenter;
    _titleL.textColor      = [UIColor colorWithRed:0.899 green:0.902 blue:0.912 alpha:1.000];
        _titleL.font = [UIFont boldSystemFontOfSize:20];
        [self.contentView addSubview:_titleL];
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageV.mas_top).offset(50);
            make.left.equalTo(_imageV.mas_left).offset(0);
            make.bottom.equalTo(_imageV.mas_bottom).offset(-(kScreenWidth *(9.0/16.0))*0.5);
            make.right.equalTo(_imageV.mas_right).offset(0);
        }];
        // 分类和时间
    _cWithTL               = [[UILabel alloc] init];
    _cWithTL.textAlignment = NSTextAlignmentCenter;
    _cWithTL.font          = [UIFont boldSystemFontOfSize:18];
    _cWithTL.textColor     = [UIColor colorWithRed:0.899 green:0.902 blue:0.912 alpha:1.000];
        [self.contentView addSubview:_cWithTL];
        [_cWithTL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleL.mas_bottom).offset(10);
            make.left.equalTo(_imageV.mas_left).offset(0);
            make.height.mas_equalTo(22);
            make.right.equalTo(_imageV.mas_right).offset(0);
        }];
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

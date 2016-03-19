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
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        KWS(ws);
        // 初始化背景视图
        _imageV = [[UIImageView alloc] init];
//        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageV];
       
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView.mas_top).offset(0);
            make.left.equalTo(ws.contentView.mas_left).offset(0);
            make.bottom.equalTo(ws.contentView.mas_bottom).offset(0);
            make.right.equalTo(ws.contentView.mas_right).offset(0);
            make.height.equalTo(ws.contentView.mas_height);
            make.width.equalTo(ws.contentView.mas_width);
        }];
        
        // 标题
        _titleL = [[UILabel alloc] init];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.font = [UIFont systemFontOfSize:20];
        _titleL.textColor = [UIColor colorWithRed:0.99 green:0.99 blue:1 alpha:1];
        [self.contentView addSubview:_titleL];
        [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView.mas_top).offset(90);
            make.left.equalTo(ws.contentView.mas_left).offset(0);
            make.bottom.equalTo(ws.contentView.mas_bottom).offset(-120);
            make.right.equalTo(ws.contentView.mas_right).offset(0);
//            make.height.equalTo(@30);
            make.width.equalTo(ws.contentView.mas_width);
        }];
        // 分类和时间
        _cWithTL = [[UILabel alloc] init];
        _cWithTL.textAlignment = NSTextAlignmentCenter;
        _cWithTL.font = [UIFont systemFontOfSize:18];
        _cWithTL.textColor = [UIColor colorWithRed:0.99 green:0.99 blue:1 alpha:1];
        [self.contentView addSubview:_cWithTL];
        [_cWithTL mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(ws.contentView.mas_top).offset(125);
            make.left.equalTo(ws.contentView.mas_left).offset(0);
            make.bottom.equalTo(ws.contentView.mas_bottom).offset(-95);
            make.right.equalTo(ws.contentView.mas_right).offset(0);
            make.width.equalTo(ws.contentView.mas_width);
            
        }];

    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

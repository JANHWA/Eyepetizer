//
//  ChoiceCell.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "ChoiceCell.h"

@implementation ChoiceCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(ChoicModel *)model
{
    _model = model;
    [_appImage sd_setImageWithURL:[NSURL URLWithString:_model.coverForFeed]];
    _appTitle.text = _model.title;
    _appCategory.text = [NSString stringWithFormat:@"#%@",_model.category];
    _appDuration.text = [NSString stringWithFormat:@"%@\"",_model.duration];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

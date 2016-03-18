//
//  ChoiceCell.h
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoicModel.h"

@interface ChoiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *appImage;
@property (weak, nonatomic) IBOutlet UILabel *appTitle;
@property (weak, nonatomic) IBOutlet UILabel *appCategory;
@property (weak, nonatomic) IBOutlet UILabel *appDuration;


@property (nonatomic, strong) ChoicModel *model;


@end

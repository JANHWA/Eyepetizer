//
//  WRankModel.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "WRankModel.h"

@implementation WRankModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"my_description"}];
}

@end

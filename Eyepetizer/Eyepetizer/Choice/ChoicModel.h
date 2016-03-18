//
//  ChoicModel.h
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "JSONModel.h"

@interface ChoicModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *category;
@property (nonatomic, copy) NSString<Optional> *duration;
@property (nonatomic, copy) NSString<Optional> *playUrl;
@property (nonatomic, copy) NSString<Optional> *coverForFeed;
@property (nonatomic, copy) NSString<Optional> *my_description;
@property (nonatomic, copy) NSString<Optional> *coverBlurred;


@end

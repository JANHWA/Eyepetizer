//
//  DetailModel.h
//  Eyepetizer
//
//  Created by qianfeng on 16/3/20.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "JSONModel.h"

@interface DetailModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *category;
@property (nonatomic, copy) NSString<Optional> *duration;
@property (nonatomic, copy) NSString<Optional> *playUrl;
@property (nonatomic, copy) NSString<Optional> *feed;
@property (nonatomic, copy) NSString<Optional> *my_description;
@property (nonatomic, copy) NSString<Optional> *blurred;

@end

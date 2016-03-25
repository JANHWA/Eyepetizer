//
//  CollectModel+CoreDataProperties.h
//  Eyepetizer
//
//  Created by qianfeng on 16/3/24.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CollectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *category;
@property (nullable, nonatomic, retain) NSString *duration;
@property (nullable, nonatomic, retain) NSString *playUrl;
@property (nullable, nonatomic, retain) NSString *coverForFeed;
@property (nullable, nonatomic, retain) NSString *my_description;
@property (nullable, nonatomic, retain) NSString *coverBlurred;

@end

NS_ASSUME_NONNULL_END

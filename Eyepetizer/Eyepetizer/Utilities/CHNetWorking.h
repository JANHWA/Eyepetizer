//
//  CHNetWorking.h
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"



typedef void(^SucBlock)(id responseObject);
typedef void(^FailureBlock)();

@interface CHNetWorking : NSObject


+ (instancetype)shareManager;


- (void)requestData:(NSString *)urlString parameters:(NSDictionary *)dic sucBlock:(SucBlock)sucBlock failureBlock:(FailureBlock)failureBlock;


@end

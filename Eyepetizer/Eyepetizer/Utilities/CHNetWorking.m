//
//  CHNetWorking.m
//  Eyepetizer
//
//  Created by qianfeng on 16/3/18.
//  Copyright © 2016年 CheeHwa. All rights reserved.
//

#import "CHNetWorking.h"



@implementation CHNetWorking


+ (instancetype)shareManager
{
    static CHNetWorking *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[CHNetWorking alloc] init];
        }
    });
    return manager;
}

- (void)requestData:(NSString *)urlString parameters:(NSDictionary *)dic sucBlock:(SucBlock)sucBlock failureBlock:(FailureBlock)failureBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (sucBlock) {
            sucBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
        if (failureBlock) {
            failureBlock();
        }
    }];
}

@end

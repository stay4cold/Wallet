//
//  Api.h
//  Vanthink_tea
//
//  Created by 王成浩 on 2018/6/9.
//  Copyright © 2018年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

typedef void(^onSuccess)(id response);
typedef void(^onFailure)(NSError * _Nonnull error);

@interface Api : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end

//
//  ConfigManager.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "ConfigManager.h"

static NSString *const kAssetsID = @"assetsID";

@implementation ConfigManager

+ (NSNumber *)getAssetsId {
    NSNumber *n = [[NSUserDefaults standardUserDefaults] objectForKey:kAssetsID];
    if (n == nil) {
        n = [NSNumber numberWithInt:-1];
    }
    return n;
}

+ (void)setAssetsId:(NSNumber *)ID {
    [[NSUserDefaults standardUserDefaults] setInteger:[ID integerValue] forKey:kAssetsID];
}

@end

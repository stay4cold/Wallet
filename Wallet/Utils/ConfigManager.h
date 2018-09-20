//
//  ConfigManager.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigManager : NSObject

+ (NSNumber *)getAssetsId;
+ (void)setAssetsId:(NSNumber *)ID;

@end

//
//  Dao.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dao : NSObject

+ (FMDatabase *)sharedDao;

@end

//
//  AssetsTypeModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssetsTypeModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, assign) NSInteger type;

+ (instancetype)assetsWithName:(NSString *)name imgName:(NSString *)imgName type:(NSInteger)type;

@end

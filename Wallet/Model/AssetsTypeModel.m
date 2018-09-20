//
//  AssetsTypeModel.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsTypeModel.h"

@implementation AssetsTypeModel

+ (instancetype)assetsWithName:(NSString *)name imgName:(NSString *)imgName type:(NSInteger)type {
    AssetsTypeModel *assets = [AssetsTypeModel new];
    assets.name = name;
    assets.imgName = imgName;
    assets.type = type;
    return assets;
}

@end

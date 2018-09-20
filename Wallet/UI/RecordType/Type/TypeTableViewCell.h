//
//  TypeTableViewCell.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordTypeModel.h"
#import "AssetsTypeModel.h"
#import "BankModel.h"

@interface TypeTableViewCell : UITableViewCell

@property (nonatomic, strong) RecordTypeModel *model;
@property (nonatomic, strong) AssetsTypeModel *assets;
@property (nonatomic, strong) BankModel *bank;

@end

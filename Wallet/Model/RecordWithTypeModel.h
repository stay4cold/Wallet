//
//  RecordWithTypeModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "RecordModel.h"
#import "RecordTypeModel.h"

@interface RecordWithTypeModel : RecordModel

@property (nonatomic, strong) NSMutableArray<RecordTypeModel *> *recordTypes;

@end

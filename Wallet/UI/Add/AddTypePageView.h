//
//  AddTypePageView.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/17.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordTypeModel.h"
#import "RecordWithTypeModel.h"

@interface AddTypePageView : UIView

@property (nonatomic, strong) NSMutableArray<RecordTypeModel *> *dataArray;
@property (nonatomic, assign) RecordType type;
@property (nonatomic, strong) RecordWithTypeModel *record;

@end

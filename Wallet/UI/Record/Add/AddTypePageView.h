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
#import "RecordTypeDao.h"

@interface AddTypePageView : UIView

@property (nonatomic, assign) RecordType type;
@property (nonatomic, strong) RecordWithTypeModel *record;
@property (nonatomic, strong) NSNumber *checkID;

@end

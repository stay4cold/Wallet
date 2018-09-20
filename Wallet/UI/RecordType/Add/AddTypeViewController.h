//
//  AddTypeViewController.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordTypeModel.h"

@interface AddTypeViewController : UIViewController

@property (nonatomic, strong) RecordTypeModel *model;//修改
@property (nonatomic, assign) RecordType type;//添加新类型(支出/收入)

@end

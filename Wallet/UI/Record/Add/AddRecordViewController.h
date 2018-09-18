//
//  AddRecordViewController.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordWithTypeModel.h"

@interface AddRecordViewController : UIViewController

@property (assign, nonatomic, getter=isSuccessive) BOOL successive;//连续记账
@property (nonatomic, strong) RecordWithTypeModel *record;

@end

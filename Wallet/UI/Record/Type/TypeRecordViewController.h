//
//  TypeRecordViewController.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/26.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordDao.h"

@interface TypeRecordViewController : UIViewController

@property (nonatomic, strong) TypeSumMoneyModel *model;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;

@end

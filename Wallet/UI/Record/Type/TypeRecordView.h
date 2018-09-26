//
//  TypeRecordView.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/26.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeSumMoneyModel.h"
#import "RecordDao.h"
#import "TimeRecordModel.h"
#import "HomeTableViewCell.h"
#import "AddRecordViewController.h"

@interface TypeRecordView : UIView
//sortType:0时间 1金额
- (void)configModel:(TypeSumMoneyModel *)model withYear:(NSInteger)year withMonth:(NSInteger)month withSortType:(NSInteger)sortType;;

@end

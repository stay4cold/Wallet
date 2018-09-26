//
//  ReportViewCell.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/26.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeSumMoneyModel.h"

@interface ReportViewCell : UITableViewCell

@property (nonatomic, strong) TypeSumMoneyModel *model;
@property (nonatomic, strong) NSDecimalNumber *max;

@end

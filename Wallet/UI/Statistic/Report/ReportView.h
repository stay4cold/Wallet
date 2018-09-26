//
//  ReportView.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/24.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wallet-Bridging-Header.h"
#import "RecordDao.h"
#import "ReportViewCell.h"
#import "PercentFormatter.h"

@interface ReportView : UIView

- (void)setYear:(NSInteger)year withMonth:(NSInteger)month;

@end

//
//  AssetsDetailView.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetsTransferRecordDao.h"
#import "AssetsModifyRecordDao.h"

@interface AssetsDetailView : UITableView

//type:0 转账 1 修改
- (void)setAssetsID:(NSNumber *)assetsID withType:(NSInteger)type;

@end

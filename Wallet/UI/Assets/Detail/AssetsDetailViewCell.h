//
//  AssetsDetailViewCell.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetsTransferRecordWithAssetsModel.h"
#import "AssetsModifyRecordModel.h"

@interface AssetsDetailViewCell : UITableViewCell

@property (nonatomic, strong) AssetsTransferRecordWithAssetsModel *transferModel;
@property (nonatomic, strong) AssetsModifyRecordModel *modifyModel;

@end

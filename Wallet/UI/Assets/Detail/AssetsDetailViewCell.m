//
//  AssetsDetailViewCell.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsDetailViewCell.h"

@interface AssetsDetailViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moneyHeight;

@end

@implementation AssetsDetailViewCell

- (void)setTransferModel:(AssetsTransferRecordWithAssetsModel *)transferModel {
    _transferModel = transferModel;
    self.typeImageView.image = [UIImage imageNamed:@"ic_transform"];
    self.nameLabel.text = @"转账";
    self.remarkLabel.text = _transferModel.remark;
    self.subLabel.text = [NSString stringWithFormat:@"%@ ➡ %@", _transferModel.assetsNameFrom, _transferModel.assetsNameTo];
    self.moneyLabel.text = [DecimalUtils fen2Yuan:_transferModel.money];
    self.timeLabel.text = [DateUtils monthDayFor:_transferModel.time];
}

- (void)setModifyModel:(AssetsModifyRecordModel *)modifyModel {
    _modifyModel = modifyModel;
    self.typeImageView.image = [UIImage imageNamed:@"ic_balance"];
    self.nameLabel.text = @"余额调整";
    self.remarkLabel.hidden = YES;
    self.subLabel.text = [NSString stringWithFormat:@"%@ ➡ %@", [DecimalUtils fen2Yuan:_modifyModel.money_before], [DecimalUtils fen2Yuan:_modifyModel.money]];
    self.moneyLabel.hidden = YES;
    self.timeTop.constant = 0;
    self.moneyHeight.constant = 0;
    self.timeLabel.text = [DateUtils monthDayFor:_modifyModel.create_time];
}

@end

//
//  AssetsViewCell.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsViewCell.h"

@interface AssetsViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkTop;

@end

@implementation AssetsViewCell

- (void)setModel:(AssetsModel *)model {
    _model = model;
    self.typeImageView.image = [UIImage imageNamed:_model.img_name];
    self.nameLabel.text = _model.name;
    self.remarkLabel.text = _model.remark;
    if (_model.remark.length == 0) {
        self.remarkTop.constant = 0;
        self.remarkHeight.constant = 0;
    } else {
        self.remarkTop.constant = 5;
        self.remarkHeight.constant = 19;
    }
    self.amountLabel.text = [DecimalUtils fen2Yuan:_model.money];
}

@end

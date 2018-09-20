//
//  ChooseAssetsViewCell.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "ChooseAssetsViewCell.h"

@interface ChooseAssetsViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkTop;


@end

@implementation ChooseAssetsViewCell

- (void)setModel:(AssetsModel *)model {
    _model = model;
    self.typeImageView.image = [UIImage imageNamed:_model.img_name];
    self.nameLabel.text = _model.name;
    self.remarkLabel.text = _model.remark;
    if (_model.remark.length == 0) {
        self.remarkHeight.constant = 0;
        self.remarkTop.constant = 0;
    } else {
        self.remarkHeight.constant = 19;
        self.remarkTop.constant = 5;
    }
}

@end

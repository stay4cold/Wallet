//
//  HomeTableViewCell.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkTopMargin;

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.remarkHeight.constant = 0;
//    self.remarkTopMargin.constant = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(RecordWithTypeModel *)model {
    _model = model;
    self.typeImageView.image = [UIImage imageNamed:_model.recordTypes[0].img_name];
    self.typeLabel.text = _model.recordTypes[0].name;
    self.remarkLabel.text = _model.remark;
    if (_model.remark.length == 0) {
        self.remarkHeight.constant = 0;
        self.remarkTopMargin.constant = 0;
    } else {
        self.remarkHeight.constant = 19;
        self.remarkTopMargin.constant = 5;
    }
    if (_model.recordTypes[0].type == RecordTypeOutlay) {
        self.moneyLabel.textColor = ColorOutlay;
    } else {
        self.moneyLabel.textColor = ColorIncome;
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"%@", _model.money];
}

@end

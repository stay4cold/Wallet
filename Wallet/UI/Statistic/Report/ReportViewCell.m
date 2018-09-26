//
//  ReportViewCell.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/26.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "ReportViewCell.h"

@interface ReportViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressWidth;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ReportViewCell

- (void)setModel:(TypeSumMoneyModel *)model {
    _model = model;
    self.typeImageView.image = [UIImage imageNamed:_model.imgName];
    self.nameLabel.text = _model.typeName;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@%@", [ConfigManager getCurrentSymbol], [DecimalUtils fen2Yuan:_model.typeSumMoney]];
    self.moneyLabel.textColor = _model.type == RecordTypeOutlay ? ColorOutlay : ColorIncome;
    self.countLabel.text = [NSString stringWithFormat:@"%ld笔", _model.count];
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *offset = [self.max decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10"] withBehavior:handler];
    CGFloat ratio = [[_model.typeSumMoney decimalNumberByAdding:offset] decimalNumberByDividingBy:[self.max decimalNumberByAdding:offset]].floatValue;
    self.progressWidth.constant = -self.backView.width * (1 - ratio);
}

@end

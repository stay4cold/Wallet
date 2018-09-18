//
//  AddRecordItemViewCell.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/15.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AddTypePageItemViewCell.h"

@interface AddTypePageItemViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation AddTypePageItemViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(RecordTypeModel *)model {
    self.typeLabel.text = model.name;
    self.typeImageView.image = [UIImage imageNamed:model.img_name];
    self.checkImageView.hidden = !model.isChecked;
}

@end

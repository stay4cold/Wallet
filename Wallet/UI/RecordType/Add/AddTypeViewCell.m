//
//  AddTypeViewCell.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AddTypeViewCell.h"

@interface AddTypeViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;

@end

@implementation AddTypeViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImgName:(NSString *)imgName {
    _imgName = imgName;
    self.typeImageView.image = [UIImage imageNamed:_imgName];
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    self.checkImageView.hidden = !_checked;
}

@end

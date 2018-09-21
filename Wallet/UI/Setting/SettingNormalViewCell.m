//
//  SettingNormalViewCell.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "SettingNormalViewCell.h"

@interface SettingNormalViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UISwitch *checkSwitch;

@end

@implementation SettingNormalViewCell

- (IBAction)checkChanged:(UISwitch *)sender {
    self.checkItem.checked = sender.isOn;
    [ConfigManager setFast:sender.isOn];
}

- (void)setNormalItem:(NormalItem *)normalItem {
    _normalItem = normalItem;
    self.titleLabel.text = _normalItem.title;
    self.contentLabel.text = _normalItem.content;
    self.checkSwitch.hidden = YES;
}

- (void)setCheckItem:(CheckItem *)checkItem {
    _checkItem = checkItem;
    self.titleLabel.text = _checkItem.title;
    self.contentLabel.text = _checkItem.content;
    self.checkSwitch.hidden = NO;
    self.checkSwitch.on = _checkItem.isChecked;
}

@end

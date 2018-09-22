//
//  TransferViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/22.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "TransferViewController.h"
#import "KeyboardView.h"
#import "ChooseAssetsViewController.h"
#import "AssetsDao.h"
#import "AssetsTransferRecordDao.h"

@interface TransferViewController () <KeyboardViewDelegate, ChooseAssetsDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *outerView;
@property (weak, nonatomic) IBOutlet UIView *outerAssetView;
@property (weak, nonatomic) IBOutlet UILabel *outerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *outerRemarkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *outerTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *outerHintView;

@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet UIView *innerAssetView;
@property (weak, nonatomic) IBOutlet UILabel *innerHintView;
@property (weak, nonatomic) IBOutlet UIImageView *innerTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *innerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *innerRemarkLabel;

@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UITextField *remarkField;

@property (weak, nonatomic) IBOutlet KeyboardView *keyboardView;

@property (weak, nonatomic) IBOutlet UIView *pickView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickView;

@property (nonatomic, strong) NSDate *chooseDate;
@property (nonatomic, strong) AssetsModel *outerAssets;
@property (nonatomic, strong) AssetsModel *innerAssets;

@property (nonatomic, assign) NSInteger type;//0转出账户，1转入账户
@end

@implementation TransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转账";
    
    [self.outerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseOuterAsset)]];
    [self.innerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseInnerAsset)]];
    self.keyboardView.delegate = self;
    [self.dateBtn setTitle:[DateUtils wordTimeForDate:self.chooseDate] forState:UIControlStateNormal];
}

- (void)update {
    BOOL outerHidden = self.outerAssets == nil;
    self.outerAssetView.hidden = outerHidden;
    self.outerHintView.hidden = !outerHidden;
    if (self.outerAssets) {
        self.outerTypeImageView.image = [UIImage imageNamed:self.outerAssets.img_name];
        self.outerNameLabel.text = self.outerAssets.name;
        self.outerRemarkLabel.text = self.outerAssets.remark;
    }
    
    BOOL innerHidden = self.innerAssets == nil;
    self.innerAssetView.hidden = innerHidden;
    self.innerHintView.hidden = !innerHidden;
    if (self.innerAssets) {
        self.innerTypeImageView.image = [UIImage imageNamed:self.innerAssets.img_name];
        self.innerNameLabel.text = self.innerAssets.name;
        self.innerRemarkLabel.text = self.innerAssets.remark;
    }
}

- (NSDate *)chooseDate {
    if (!_chooseDate) {
        _chooseDate = [DateUtils todayDate];
    }
    return _chooseDate;
}

- (IBAction)chooseDate:(UIButton *)sender {
    self.pickView.hidden = NO;
    self.datePickView.date = self.chooseDate;
    self.datePickView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    self.datePickView.datePickerMode = UIDatePickerModeDate;
    self.datePickView.maximumDate = [NSDate date];//设置最大日期
}

- (IBAction)dateComplete:(id)sender {
    self.pickView.hidden = YES;
    self.chooseDate = self.datePickView.date;
    [self.dateBtn setTitle:[DateUtils wordTimeForDate:self.chooseDate] forState:UIControlStateNormal];
}

- (void)chooseOuterAsset {
    self.type = 0;
    ChooseAssetsViewController *cc = [ChooseAssetsViewController new];
    cc.checkedID = self.outerAssets.ID;
    cc.noAndAddHidden = YES;
    cc.delegate = self;
    [self.navigationController pushViewController:cc animated:YES];
}

- (void)chooseInnerAsset {
    self.type = 1;
    ChooseAssetsViewController *cc = [ChooseAssetsViewController new];
    cc.checkedID = self.innerAssets.ID;
    cc.noAndAddHidden = YES;
    cc.delegate = self;
    [self.navigationController pushViewController:cc animated:YES];
}

#pragma mark - KeyboardViewDelegate

- (void)keyboardView:(KeyboardView *)keyboard confirm:(NSString *)text {
    if (!self.outerAssets || !self.innerAssets) {
        [self showHUDInView:self.view justWithText:@"请先选择账户" disMissAfterDelay:2];
        return;
    }
    if ([self.innerAssets.ID isEqual:self.outerAssets.ID]) {
        [self showHUDInView:self.view justWithText:@"请选择不同的账户" disMissAfterDelay:2];
        return;
    }
    AssetsTransferRecordModel *model = [AssetsTransferRecordModel new];
    model.assets_id_from = self.outerAssets.ID;
    model.assets_id_to = self.innerAssets.ID;
    model.money = [DecimalUtils yuan2Fen:text];
    model.create_time = self.chooseDate;
    model.remark = self.remarkField.text;
    model.time = [NSDate date];
    
    [AssetsTransferRecordDao insertTransferRecord:[NSMutableArray arrayWithObject:model]];
    self.outerAssets.money = [self.outerAssets.money decimalNumberBySubtracting:model.money];
    [AssetsDao updateAssets:[NSMutableArray arrayWithObject:self.outerAssets]];
    self.innerAssets.money = [self.innerAssets.money decimalNumberByAdding:model.money];
    [AssetsDao updateAssets:[NSMutableArray arrayWithObject:self.innerAssets]];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ChooseAssetsDelegate

- (void)chooseAssets:(AssetsModel *)assets {
    if (self.type == 0) {
        self.outerAssets = assets;
    } else {
        self.innerAssets = assets;
    }
    [self update];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}
@end

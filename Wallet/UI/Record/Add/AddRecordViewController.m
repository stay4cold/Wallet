//
//  AddRecordViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AddRecordViewController.h"
#import "AddTypePageView.h"
#import "KeyboardView.h"
#import "RecordTypeDao.h"
#import "RecordDao.h"
#import "ChooseAssetsViewController.h"

@interface AddRecordViewController () <KeyboardViewDelegate, ChooseAssetsDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeControl;
@property (weak, nonatomic) IBOutlet AddTypePageView *outlayTypePageView;
@property (weak, nonatomic) IBOutlet AddTypePageView *incomeTypePageView;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UITextField *remarkField;
@property (weak, nonatomic) IBOutlet UILabel *assetsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *assetsImgView;
@property (weak, nonatomic) IBOutlet KeyboardView *keyboardView;
@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) AssetsModel *assets;
@property (nonatomic, strong) AssetsModel *oldAssets;
@property (nonatomic, copy) NSString *noAccount;

@end

@implementation AddRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isSuccessive) {
        self.title = NSLocalizedString(@"text_add_record_successive", nil);
    } else {
        self.title = NSLocalizedString(@"text_add_record", nil);
    }
    
    if (self.recordWithType) {
        self.title = NSLocalizedString(@"text_modify_record", nil);
    }
    
    self.keyboardView.delegate = self;
    
    [self.assetsLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAssets)]];
    
    if (self.recordWithType) {//修改
        self.remarkField.text = self.recordWithType.remark;
        self.keyboardView.text = [DecimalUtils fen2YuanNoSeparator:self.recordWithType.money];
        self.currentDate = self.recordWithType.time;
        if (self.recordWithType.recordTypes[0].type == RecordTypeIncome) {
            [self.typeControl setSelectedSegmentIndex:1];
            self.outlayTypePageView.hidden = YES;
            self.incomeTypePageView.hidden = NO;
        }
        if (self.recordWithType.assets_id == nil || [self.recordWithType.assets_id integerValue] == AssetsTypeNo) {
            [self configAssetsName:self.noAccount withImg:nil];
        } else {
            [self configAssetsByID:self.recordWithType.assets_id];
        }
    } else {//新建
        self.currentDate = [NSDate date];
        NSNumber *assetsId = [ConfigManager getAssetsId];
        if ([assetsId isEqual:[NSNumber numberWithInt:-1]]) {
            [self configAssetsName:self.noAccount withImg:nil];
        } else {
            [self configAssetsByID:assetsId];
        }
    }
    [self.dateBtn setTitle:[DateUtils wordTimeForDate:self.currentDate] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadTypePage];
}

- (IBAction)typeChanged:(UISegmentedControl *)sender {
    self.outlayTypePageView.hidden = sender.selectedSegmentIndex == 1;
    self.incomeTypePageView.hidden = sender.selectedSegmentIndex == 0;
}

- (IBAction)saveDate:(UIButton *)sender {
    self.pickerView.hidden = YES;
    self.currentDate = self.datePicker.date;
    [self.dateBtn setTitle:[DateUtils wordTimeForDate:self.currentDate] forState:UIControlStateNormal];
}

- (IBAction)tapDateBtn:(UIButton *)sender {
    self.datePicker.date = self.currentDate;
    self.datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.maximumDate = [NSDate date];//设置最大日期
    self.pickerView.hidden = NO;
}

- (NSString *)noAccount {
    if (!_noAccount) {
        _noAccount = NSLocalizedString(@"text_no_choose_account", nil);
    }
    return _noAccount;
}

//选择Assets
- (void)showAssets {
    ChooseAssetsViewController *avc = [ChooseAssetsViewController new];
    avc.delegate = self;
    avc.checkedID = self.assets ? self.assets.ID : [NSNumber numberWithInt:AssetsTypeNo];
    [self.navigationController pushViewController:avc animated:YES];
}

- (void)loadTypePage {
    [self.incomeTypePageView addRecord:self.recordWithType withType:RecordTypeIncome];
    [self.outlayTypePageView addRecord:self.recordWithType withType:RecordTypeOutlay];
}

- (void)configAssetsName:(NSString *)name withImg:(NSString *)imgName {
    self.assetsLabel.text = name;
    if (imgName.length > 0) {
        self.assetsImgView.image = [UIImage imageNamed:imgName];
        self.assetsImgView.hidden = NO;
    } else {
        self.assetsImgView.hidden = YES;
    }
}

- (void)configAssetsByID:(NSNumber *)ID {
    AssetsModel *assets = [AssetsDao getAssetsById:ID];
    if (assets) {
        self.assets = assets;
        if (self.recordWithType) {
            //修改记录
            self.oldAssets = assets;
        }
        [self configAssetsName:assets.name withImg:assets.img_name];
    } else {
        [self configAssetsName:self.noAccount withImg:nil];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

#pragma mark - KeyboardViewDelegate

- (void)keyboardView:(KeyboardView *)keyboard confirm:(NSString *)text {
    if (text.length == 0) {
        [self showHUDInView:self.view justWithText:NSLocalizedString(@"hint_enter_money", nil) disMissAfterDelay:2];
    } else {
        if (self.recordWithType) {
            [self updateRecord:text];
        } else {
            [self insertRecord:text];
        }
    }
}

#pragma mark - ChooseAssetsDelegate

- (void)chooseAssets:(AssetsModel *)assets {
    self.assets = assets;
    if (assets.type == AssetsTypeNo) {
        self.assets = nil;
        [self configAssetsName:self.noAccount withImg:nil];
    } else {
        [self configAssetsName:assets.name withImg:assets.img_name];
    }
}

#pragma mark - private method

- (void)insertRecord:(NSString *)money {
    [self showHUDInView:self.view WithText:NSLocalizedString(@"text_update", nil)];
    RecordModel *record = [RecordModel new];
    record.money = [DecimalUtils yuan2Fen:money];
    record.remark = self.remarkField.text;
    if (record.remark.length == 0) {
        record.remark = @"";
    }
    record.time = self.currentDate;
    record.create_time = [NSDate date];
    record.record_type_id = self.typeControl.selectedSegmentIndex == 0 ? self.outlayTypePageView.checkID : self.incomeTypePageView.checkID;
    record.assets_id = self.assets ? self.assets.ID : [NSNumber numberWithInt:AssetsTypeNo];
    BOOL state = [RecordDao insertRecord:record];
    if (state) {
        [ConfigManager setAssetsId:record.assets_id];
        [self showHUDInView:self.view justWithText:NSLocalizedString(@"toast_save_assets_success", nil) disMissAfterDelay:2];
    } else {
        [self showHUDInView:self.view justWithText:NSLocalizedString(@"toast_save_assets_fail", nil) disMissAfterDelay:2];
    }
    if (self.isSuccessive) {
        self.keyboardView.text = @"";
        self.remarkField.text = @"";
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)updateRecord:(NSString *)money {
    [self showHUDInView:self.view WithText:NSLocalizedString(@"text_update", nil)];
    self.recordWithType.money = [DecimalUtils yuan2Fen:money];
    self.recordWithType.remark = self.remarkField.text;
    if (self.recordWithType.remark.length == 0) {
        self.recordWithType.remark = @"";
    }
    self.recordWithType.time = self.currentDate;
    self.recordWithType.record_type_id = self.typeControl.selectedSegmentIndex == 0 ? self.outlayTypePageView.checkID : self.incomeTypePageView.checkID;
    self.recordWithType.assets_id = self.assets ? self.assets.ID : [NSNumber numberWithInt:AssetsTypeNo];
    RecordType oldType = self.recordWithType.recordTypes[0].type;
    //更新record
    if ([RecordDao updateRecords:[NSMutableArray arrayWithObject:self.recordWithType]]) {
        [self updateAssetsForModify:oldType type:self.typeControl.selectedSegmentIndex oldAssets:self.oldAssets assets:self.assets record:self.recordWithType];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)updateAssetsForModify:(RecordType)oldType type:(RecordType)type oldAssets:(AssetsModel *)oldAssets assets:(AssetsModel *)assets record:(RecordModel *)record {
    if (oldType == type) {
        if (oldAssets == nil) {
            if (assets == nil) {
                //不用更新资产
            } else {
                if (type == RecordTypeOutlay) {
                    //减
                    assets.money = [assets.money decimalNumberBySubtracting:record.money];
                } else {
                    //加
                    assets.money = [assets.money decimalNumberByAdding:record.money];
                }
                [self updateAssets:assets other:nil];
            }
        } else {
            if (assets == nil) {
                if (type == RecordTypeOutlay) {
                    //更新oldassets, 加
                    oldAssets.money = [oldAssets.money decimalNumberByAdding:record.money];
                } else {
                    oldAssets.money = [oldAssets.money decimalNumberBySubtracting:record.money];
                }
                [self updateAssets:oldAssets other:nil];
            } else {
                if ([oldAssets.ID integerValue] == [assets.ID integerValue]) {
                    //不用更新资产
                } else {
                    if (type == RecordTypeOutlay) {
                        oldAssets.money = [oldAssets.money decimalNumberByAdding:record.money];
                        assets.money = [assets.money decimalNumberBySubtracting:record.money];
                    } else {
                        oldAssets.money = [oldAssets.money decimalNumberBySubtracting:record.money];
                        assets.money = [assets.money decimalNumberByAdding:record.money];
                    }
                    [self updateAssets:oldAssets other:assets];
                }
            }
        }
    } else {
        if (oldAssets == nil) {
            if (assets == nil) {
                //不用更新资产
            } else {
                if (type == RecordTypeOutlay) {
                    assets.money = [assets.money decimalNumberBySubtracting:record.money];
                } else {
                    assets.money = [assets.money decimalNumberByAdding:record.money];
                }
                [self updateAssets:assets other:nil];
            }
        } else {
            if (assets == nil) {
                if (oldType == RecordTypeOutlay) {
                    oldAssets.money = [oldAssets.money decimalNumberByAdding:record.money];
                } else {
                    oldAssets.money = [oldAssets.money decimalNumberBySubtracting:record.money];
                }
                [self updateAssets:oldAssets other:nil];
            } else {
                if (type == RecordTypeOutlay) {
                    oldAssets.money = [oldAssets.money decimalNumberBySubtracting:record.money];
                    assets.money = [assets.money decimalNumberBySubtracting:record.money];
                } else {
                    oldAssets.money = [oldAssets.money decimalNumberByAdding:record.money];
                    assets.money = [assets.money decimalNumberByAdding:record.money];
                }
                [self updateAssets:oldAssets other:assets];
            }
        }
    }
}

- (void)updateAssets:(AssetsModel *)assets other:(AssetsModel *)otherAssets {
    if (assets) {
        [AssetsDao updateAssets:[NSMutableArray arrayWithObject:assets]];
    }
    if (otherAssets) {
        [AssetsDao updateAssets:[NSMutableArray arrayWithObject:otherAssets]];
    }
}

@end

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

static NSString *const kNoAccount = @"不选择账户";

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

@end

@implementation AddRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isSuccessive) {
        self.title = @"记一笔(连续)";
    } else {
        self.title = @"记一笔";
    }
    
    if (self.recordWithType) {
        self.title = @"修改";
    }
    
    self.keyboardView.delegate = self;
    
    [self.assetsLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAssets)]];
    
    if (self.recordWithType) {//修改
        self.remarkField.text = self.recordWithType.remark;
        self.keyboardView.text = [DecimalUtils fen2YuanNoSeparator:self.recordWithType.money];
        self.currentDate = self.recordWithType.time;
        self.typeControl.selectedSegmentIndex = self.recordWithType.recordTypes[0].type;
        if (self.recordWithType.assets_id == nil || [self.recordWithType.assets_id integerValue] == AssetsTypeNo) {
            [self configAssetsName:kNoAccount withImg:nil];
        } else {
            [self configAssetsByID:self.recordWithType.assets_id];
        }
    } else {//新建
        self.currentDate = [NSDate date];
        NSNumber *assetsId = [ConfigManager getAssetsId];
        if ([assetsId isEqual:[NSNumber numberWithInt:-1]]) {
            [self configAssetsName:kNoAccount withImg:nil];
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

- (void)showAssets {
    ChooseAssetsViewController *avc = [ChooseAssetsViewController new];
    avc.delegate = self;
    [self.navigationController pushViewController:avc animated:YES];
}

- (void)loadTypePage {
    self.incomeTypePageView.type = RecordTypeIncome;
    self.incomeTypePageView.record = self.recordWithType;
    self.outlayTypePageView.type = RecordTypeOutlay;
    self.outlayTypePageView.record = self.recordWithType;

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
        [self configAssetsName:kNoAccount withImg:nil];
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
        [self showHUDInView:self.view justWithText:@"请输入金额" disMissAfterDelay:2];
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
        [self configAssetsName:kNoAccount withImg:nil];
    } else {
        [self configAssetsName:assets.name withImg:assets.img_name];
    }
}

#pragma mark - private method

- (void)insertRecord:(NSString *)money {
    [self showHUDInView:self.view WithText:@"正在更新..."];
    RecordModel *record = [RecordModel new];
    record.money = [DecimalUtils yuan2Fen:money];
    record.remark = self.remarkField.text;
    if (record.remark.length == 0) {
        record.remark = @"";
    }
    record.time = self.currentDate;
    record.create_time = [NSDate date];
    record.record_type_id = self.typeControl.selectedSegmentIndex == 0 ? self.outlayTypePageView.checkID : self.incomeTypePageView.checkID;
    record.assets_id = self.assets ? self.assets.ID : [NSNumber numberWithInt:-1];
    BOOL state = [RecordDao insertRecord:record];
    if (state) {
        [ConfigManager setAssetsId:record.assets_id];
        [self showHUDInView:self.view justWithText:@"记账成功" disMissAfterDelay:2];
    } else {
        [self showHUDInView:self.view justWithText:@"记账失败" disMissAfterDelay:2];
    }
    if (self.isSuccessive) {
        self.keyboardView.text = @"";
        self.remarkField.text = @"";
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)updateRecord:(NSString *)money {
    
}

@end

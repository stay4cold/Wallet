//
//  AddAssetsViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AddAssetsViewController.h"
#import "BankViewController.h"
#import "AssetsDao.h"
#import "ChooseAssetsViewController.h"
#import "AssetsModifyRecordDao.h"

@interface AddAssetsViewController () <BankViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *remarkField;
@property (weak, nonatomic) IBOutlet UITextField *remainField;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation AddAssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    
    if (self.assetsTypeModel) {//新建
        self.title = @"新建资产账户";
        self.typeImageView.image = [UIImage imageNamed:self.assetsTypeModel.imgName];
        self.nameField.text = self.assetsTypeModel.name;
        if (self.assetsTypeModel.type == 2) {
            [self.typeImageView addGestureRecognizer:self.tapGesture];
        }
    } else if (self.assetsModel) {//修改
        self.title = @"修改资产账户";
        self.typeImageView.image = [UIImage imageNamed:self.assetsModel.img_name];
        self.nameField.text = self.assetsModel.name;
        self.remarkField.text = self.assetsModel.remark;
        self.remainField.text = [DecimalUtils fen2YuanNoSeparator:self.assetsModel.money];
        if (self.assetsModel.type == 2) {
            [self.typeImageView addGestureRecognizer:self.tapGesture];
        }
    } else {//数据错误，直接返回
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseBank)];
    }
    return _tapGesture;
}

- (void)save {
    NSString *name = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (name.length == 0) {
        [self showHUDInView:self.view justWithText:@"请输入资产名称" disMissAfterDelay:2];
        return;
    }
    NSString *remarkName = [self.remarkField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSDecimalNumber *money = [DecimalUtils yuan2Fen:[self.remainField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    if (self.assetsTypeModel) {//新建
        AssetsModel *assets = [AssetsModel new];
        assets.name = name;
        assets.img_name = self.assetsTypeModel.imgName;
        assets.type = self.assetsTypeModel.type;
        assets.remark = remarkName;
        assets.create_time = [NSDate date];
        assets.money = money;
        assets.money_init = money;
        [AssetsDao insertAssets:[NSMutableArray arrayWithObject:assets]];
        UIViewController *target = [self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count -3)];
        [self.navigationController popToViewController:target animated:YES];
    } else {//更新
        self.assetsModel.name = name;
        self.assetsModel.remark = remarkName;
        NSDecimalNumber *moneyBefore = self.assetsModel.money;
        self.assetsModel.money = money;
        [AssetsDao updateAssets:[NSMutableArray arrayWithObject:self.assetsModel]];
        if (![money isEqual:moneyBefore]) {
            AssetsModifyRecordModel *modifyModel = [AssetsModifyRecordModel new];
            modifyModel.assets_id = self.assetsModel.ID;
            modifyModel.money_before = moneyBefore;
            modifyModel.money = self.assetsModel.money;
            modifyModel.create_time = [NSDate date];
            [AssetsModifyRecordDao insertAssetsRecords:[NSMutableArray arrayWithObject:modifyModel]];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)chooseBank {
    BankViewController *bvc = [BankViewController new];
    bvc.delegate = self;
    [self.navigationController pushViewController:bvc animated:YES];
}

- (void)bankViewSelect:(BankModel *)bank {
    if (self.assetsTypeModel) {
        self.assetsTypeModel.imgName = bank.imgName;
    } else {
        self.assetsModel.img_name = bank.imgName;
    }
    self.typeImageView.image = [UIImage imageNamed:bank.imgName];
    self.nameField.text = bank.name;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField.text containsString:@"."] && [string containsString:@"."]) {
        return NO;
    }
    if (textField.text.length - range.length + string.length > 50) {
        return NO;
    }
    return YES;
}

@end

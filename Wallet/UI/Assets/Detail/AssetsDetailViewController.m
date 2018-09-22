//
//  AssetsDetailViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsDetailViewController.h"
#import "AssetsDetailView.h"
#import "AssetsDao.h"
#import "AddAssetsViewController.h"

@interface AssetsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *divideView;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeControl;
@property (weak, nonatomic) IBOutlet AssetsDetailView *modifyView;
@property (weak, nonatomic) IBOutlet AssetsDetailView *transferView;

@end

@implementation AssetsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"资产详情";
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_delete"] style:UIBarButtonItemStyleDone target:self action:@selector(delete)];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(modify)];
    self.navigationItem.rightBarButtonItems = @[editItem, deleteItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self update];
}

- (IBAction)typeChanged:(UISegmentedControl *)sender {
    self.modifyView.hidden = sender.selectedSegmentIndex == 0;
    self.transferView.hidden = sender.selectedSegmentIndex == 1;
}

- (void)update {
    //每次更新
    self.assets = [AssetsDao getAssetsById:self.assets.ID];
    self.typeImageView.image = [UIImage imageNamed:self.assets.img_name];
    self.nameLabel.text = self.assets.name;
    if (self.assets.remark.length != 0) {
        self.divideView.hidden = NO;
        self.remarkLabel.hidden = NO;
        self.remarkLabel.text = self.assets.remark;
    } else {
        self.divideView.hidden = YES;
        self.remarkLabel.hidden = YES;
    }
    NSString *moneyTitle = [ConfigManager getCurrentSymbol];
    if (moneyTitle.length != 0) {
        moneyTitle = [NSString stringWithFormat:@"(%@)", moneyTitle];
    }
    self.moneyTitleLabel.text = [NSString stringWithFormat:@"账户余额%@", moneyTitle];
    self.moneyLabel.text = [DecimalUtils fen2Yuan:self.assets.money];
    [self.transferView setAssetsID:self.assets.ID withType:0];
    [self.modifyView setAssetsID:self.assets.ID withType:1];
}

- (void)modify {
    AddAssetsViewController *avc = [AddAssetsViewController new];
    avc.assetsModel = self.assets;
    [self.navigationController pushViewController:avc animated:YES];
}

- (void)delete {
    WS(ws);
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"删除?" message:@"确定要删除该资产吗，不会删除该资产下的现有收支记录" preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [AssetsDao deleteAssets:ws.assets];
        [ws.navigationController popViewControllerAnimated:YES];
    }]];
    [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:ac animated:YES completion:nil];
}

@end

//
//  AssetsManagerViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AssetsViewController.h"
#import "AssetsViewCell.h"
#import "AssetsDao.h"
#import "AllAssetsViewController.h"
#import "AssetsDetailViewController.h"
#import "TransferViewController.h"

@interface AssetsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *netLabel;
@property (weak, nonatomic) IBOutlet UILabel *netMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *negLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UILabel *emptyLabel;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AssetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_add_circle"] style:UIBarButtonItemStyleDone target:self action:@selector(addAssets)];
    
    self.tableView.emptyDataSetDelegate = self.tableView;
    self.tableView.emptyDataSetSource = self.tableView;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AssetsViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configData];
}

- (void)configData {
    NSString *symbol = [ConfigManager getCurrentSymbol];
    if (symbol.length != 0) {
        symbol = [NSString stringWithFormat:@"(%@)", symbol];
    }
    self.netLabel.text = [NSString stringWithFormat:@"净资产%@", symbol];
    
    AssetsMoneyModel *assetsMoney = [AssetsDao getAssetsMoney];
    self.netMoneyLabel.text = [DecimalUtils fen2Yuan:assetsMoney.netAssets];
    self.totalLabel.text = [NSString stringWithFormat:@"总资产 %@", [DecimalUtils fen2Yuan:assetsMoney.allAssets]];
    self.negLabel.text = [NSString stringWithFormat:@"负资产 %@", [DecimalUtils fen2Yuan:assetsMoney.liabilityAssets]];
    
    self.dataArray = [AssetsDao getAllAssets];
    if (self.dataArray.count == 0) {
        self.tableView.customViewForVTEmpty = self.emptyLabel;
    }
    [self.tableView reloadData];
}

- (void)addAssets {
    [self.navigationController pushViewController:[AllAssetsViewController new] animated:YES];
}

- (IBAction)transferAssets:(id)sender {
    [self.navigationController pushViewController:[TransferViewController new] animated:YES];
}

- (UILabel *)emptyLabel {
    if (!_emptyLabel) {
        _emptyLabel = [UILabel new];
        _emptyLabel.numberOfLines = 0;
        _emptyLabel.text = @"还没有资产";
        _emptyLabel.textColor = [UIColor grayColor];
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.font = [UIFont systemFontOfSize:16];
    }
    return _emptyLabel;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AssetsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.dataArray.count == 0) {
        return nil;
    }
    return @"资产账户";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *head = (UITableViewHeaderFooterView *)view;
    head.textLabel.textColor = [UIColor colorWithHexString:@"737373"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AssetsDetailViewController *detail = [AssetsDetailViewController new];
    detail.assets = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

@end

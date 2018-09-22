//
//  HomeViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "HomeViewController.h"
#import "SettingViewController.h"
#import "StatisticViewController.h"
#import "HomeTableViewCell.h"
#import "AddRecordViewController.h"
#import "RecordTypeDao.h"
#import "RecordDao.h"
#import "DateUtils.h"
#import "TimeRecordModel.h"
#import "AssetsViewController.h"
#import "AssetsDao.h"

static NSString *kCellId = @"cell";

@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *expendTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *expendLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView1;
@property (weak, nonatomic) IBOutlet UIView *indicatorView2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (strong, nonatomic) NSMutableArray<TimeRecordModel *> *dataArray;
@property (nonatomic, strong) UILabel *emptyLabel;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账本";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStyleDone target:self action:@selector(toSettingController)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"statistics"] style:UIBarButtonItemStyleDone target:self action:@selector(toStatisticController)];
    
    //初始化type
    if ([RecordTypeDao getRecordTypeCount] < 1) {
        BOOL res = [RecordTypeDao initRecordTypes];
        if (!res) {
            NSLog(@"init record type failed !!!");
        }
    }
    
    self.tableView.emptyDataSetSource = self.tableView;
    self.tableView.emptyDataSetDelegate = self.tableView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:kCellId];
    
    self.indicatorView2.alpha = 0.5;
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(addSuccessiveAccount:)];
    [self.addBtn addGestureRecognizer:longGesture];
    UITapGestureRecognizer *budgetGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBudget:)];
    [self.budgetLabel addGestureRecognizer:budgetGesture];
    UITapGestureRecognizer *propertyGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProperty:)];
    [self.propertyLabel addGestureRecognizer:propertyGesture];
    
    if ([ConfigManager isFast]) {
        [self.navigationController pushViewController:[AddRecordViewController new] animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self update];
}

- (void)update {
    self.dataArray = nil;
    [self.tableView reloadData];
    
    //更新支出
    NSString *symbol = [ConfigManager getCurrentSymbol];
    if (symbol.length != 0) {
        symbol = [NSString stringWithFormat:@"(%@)", symbol];
    }
     self.expendTitleLabel.text = [NSString stringWithFormat:@"本月支出%@", symbol];
    self.budgetTitleLabel.text = [NSString stringWithFormat:@"剩余预算%@", symbol];
    self.incomeTitleLabel.text = [NSString stringWithFormat:@"本月收入%@", symbol];
    self.propertyTitleLabel.text = [NSString stringWithFormat:@"净资产%@", symbol];
    NSDecimalNumber *outlaySum = [NSDecimalNumber zero];
    NSDecimalNumber *incomeSum = [NSDecimalNumber zero];
    for (SumMoneyModel *sumMoney in [self currentMonthSumMoney]) {
        if (sumMoney.type == RecordTypeOutlay) {//支出
            outlaySum = sumMoney.sum_money;
        } else {
            incomeSum = sumMoney.sum_money;
        }
    }
    self.expendLabel.text = [DecimalUtils fen2Yuan:outlaySum];
    if ([ConfigManager getBudget] == 0) {
        self.budgetLabel.text = @"设置预算";
        self.budgetLabel.font = [UIFont systemFontOfSize:22];
    } else {
        NSDecimalNumber *budget = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld", [ConfigManager getBudget]]];
        self.budgetLabel.text = [DecimalUtils fen2Yuan:[[budget decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]] decimalNumberBySubtracting:outlaySum]];
        self.budgetLabel.font = [UIFont systemFontOfSize:30];
    }
    self.incomeLabel.text = [DecimalUtils fen2Yuan:incomeSum];
    self.propertyLabel.text = [DecimalUtils fen2Yuan:[AssetsDao getAssetsMoney].netAssets];
}

- (NSMutableArray<SumMoneyModel *> *)currentMonthSumMoney {
    return [RecordDao getSumMoneyFrom:[DateUtils currentMonthStart] to:[DateUtils currentMonthEnd]];
}

- (UIView *)footerView {
    if (!_footerView) {
        UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        footerLabel.font = [UIFont systemFontOfSize:14];
        footerLabel.textColor = MainTextHintColor;
        footerLabel.textAlignment = NSTextAlignmentCenter;
        footerLabel.text = @"统计页面可以查看往月记录";
        _footerView = footerLabel;
    }
    return _footerView;
}

- (UILabel *)emptyLabel {
    if (!_emptyLabel) {
        _emptyLabel = [UILabel new];
        _emptyLabel.numberOfLines = 0;
        _emptyLabel.text = @"本月未开始记账\n\n点击加号，开始记账";
        _emptyLabel.textColor = [UIColor grayColor];
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.font = [UIFont systemFontOfSize:16];
    }
    return _emptyLabel;
}

//添加新账目
- (IBAction)addAccount:(id)sender {
    [self.navigationController pushViewController:[AddRecordViewController new] animated:YES];
}

//连续记账
- (void)addSuccessiveAccount:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        AddRecordViewController *avc = [AddRecordViewController new];
        avc.successive = YES;
        [self.navigationController pushViewController:avc animated:YES];
    }
}

- (void)toSettingController {
    [self.navigationController pushViewController:[SettingViewController new] animated:YES];
}

- (void)toStatisticController {
    [self.navigationController pushViewController:[StatisticViewController new] animated:YES];
}

- (void)tapBudget:(UILabel *)sender {
    [self toSettingController];
}

- (void)tapProperty:(UILabel *)sender {
    [self.navigationController pushViewController:[AssetsViewController new] animated:YES];
}

- (NSMutableArray<TimeRecordModel *> *)dataArray {
    if (!_dataArray) {
        self.tableView.loading = NO;
        //获取当前月份的记账记录数据
        NSMutableArray *arr = [RecordDao getRangeRecordWithTypesFrom:[DateUtils currentMonthStart] to:[DateUtils currentMonthEnd]];
        _dataArray = [NSMutableArray array];
        TimeRecordModel *lastTimeRecord;
        for (RecordWithTypeModel *model in arr) {
            if (!lastTimeRecord || ![DateUtils sameDayWith:lastTimeRecord.date and:model.time]) {
                lastTimeRecord = [TimeRecordModel new];
                lastTimeRecord.date = model.time;
                [lastTimeRecord.records addObject:model];
                [_dataArray addObject:lastTimeRecord];
            } else {
                [lastTimeRecord.records addObject:model];
            }
        }
        if (arr.count > 5) {
            self.tableView.tableFooterView = self.footerView;
        } else {
            self.tableView.tableFooterView = [UIView new];
            if (arr.count == 0) {
                self.tableView.customViewForVTEmpty = self.emptyLabel;
            }
        }
    }
    return _dataArray;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        self.indicatorView1.alpha = 1;
        self.indicatorView2.alpha = 0.5;
    } else {
        self.indicatorView1.alpha = 0.5;
        self.indicatorView2.alpha = 1;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddRecordViewController *avc = [AddRecordViewController new];
    avc.recordWithType = [[self.dataArray objectAtIndex:indexPath.section].records objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:avc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(ws);
    RecordWithTypeModel *record = [[self.dataArray objectAtIndex:indexPath.section].records objectAtIndex:indexPath.row];
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@(%@%@)", record.recordTypes[0].name,[ConfigManager getCurrentSymbol], [DecimalUtils fen2Yuan:record.money]] message:@"确定删除该记录？" preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [RecordDao deleteRecord:record];
            [ws update];
        }]];
        [ac addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [ws presentViewController:ac animated:YES completion:nil];
    }];
    return @[delete];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor colorWithHexString:@"737373"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray objectAtIndex:section].records.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.model = [[self.dataArray objectAtIndex:indexPath.section].records objectAtIndex:indexPath.row];;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataArray objectAtIndex:section].title;
}

@end


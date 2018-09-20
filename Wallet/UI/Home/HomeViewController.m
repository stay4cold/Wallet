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

static NSString *kCellId = @"cell";

@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *expendLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyLabel;
@property (weak, nonatomic) IBOutlet UIView *indicatorView1;
@property (weak, nonatomic) IBOutlet UIView *indicatorView2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic, strong) UILabel *emptyLabel;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账本";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings"] style:UIBarButtonItemStyleDone target:self action:@selector(toSettingController)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"statistics"] style:UIBarButtonItemStyleDone target:self action:@selector(toStatisticController)];
    
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = ColorPrimary;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:kCellId];

    self.indicatorView2.alpha = 0.5;
    
    UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(addSuccessiveAccount:)];
    [self.addBtn addGestureRecognizer:longGesture];
    UITapGestureRecognizer *budgetGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBudget:)];
    [self.budgetLabel addGestureRecognizer:budgetGesture];
    UITapGestureRecognizer *propertyGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProperty:)];
    [self.propertyLabel addGestureRecognizer:propertyGesture];
    
    [self initData];
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
    NSLog(@"tap budget");
}

- (void)tapProperty:(UILabel *)sender {
    NSLog(@"tap property");
}

- (void)initData {
    self.tableView.loading = YES;
    //初始化type
    if ([RecordTypeDao getRecordTypeCount] < 1) {
        BOOL res = [RecordTypeDao initRecordTypes];
        if (!res) {
            NSLog(@"init record type failed !!!");
        }
    }
    //获取当前月份的记账记录数据
    self.dataArray = [RecordDao getRangeRecordWithTypesFrom:[DateUtils currentMonthStart] to:[DateUtils currentMonthEnd]];
    self.tableView.loading = NO;
    self.tableView.tableFooterView = nil;
    if (self.dataArray.count == 0) {
        self.tableView.tableFooterView = [UIView new];
        self.tableView.customViewForVTEmpty = self.emptyLabel;
    } else if (self.dataArray.count > 5) {
        self.tableView.tableFooterView = self.footerView;
    }
    [self.tableView reloadData];
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    UITableViewRowAction *edit = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
    }];
    edit.backgroundColor = ColorPrimary;
    return @[delete, edit];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"112";
//}

@end

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

@property (strong, nonatomic) NSMutableArray *dataArray;
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
    self.tableView.tableFooterView = self.footerView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:kCellId];
    
    self.indicatorView2.alpha = 0.5;
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

//添加新账目
- (IBAction)addAccount:(id)sender {
}

- (void)toSettingController {
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    [self.navigationController pushViewController:[SettingViewController new] animated:YES];
}

- (void)toStatisticController {
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = back;
    [self.navigationController pushViewController:[StatisticViewController new] animated:YES];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId forIndexPath:indexPath];
    return cell;
}

@end

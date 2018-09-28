//
//  ReportView.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/24.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "ReportView.h"
#import "TypeRecordViewController.h"

@interface ReportView() <UITableViewDelegate, UITableViewDataSource, ChartViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *outlayBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
@property (weak, nonatomic) IBOutlet UILabel *overageLabel;
@property (strong, nonatomic) PieChartView *chartView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) RecordType type;
@property (nonatomic, strong) NSDecimalNumber *max;
@property (nonatomic, strong) NSMutableArray<UIColor *> *colorArray;

@end

@implementation ReportView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = self.chartView;
    self.tableView.emptyDataSetSource = self.tableView;
    self.tableView.emptyDataSetDelegate = self.tableView;
    UILabel *label = [UILabel new];
    label.text = NSLocalizedString(@"text_empty_tip", nil);
    label.textColor = [UIColor colorWithHexString:@"737373"];
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.customViewForVTEmpty = label;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ReportViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [self updateData];
}

- (PieChartView *)chartView {
    if (!_chartView) {
        _chartView = [[PieChartView alloc] initWithFrame:CGRectMake(0, 0, self.width, 180)];
        _chartView.chartDescription.enabled = YES;
        _chartView.chartDescription.textColor = [UIColor colorWithHexString:@"737373"];
        _chartView.chartDescription.text = NSLocalizedString(@"text_small_tip", nil);
        _chartView.noDataText = @"";
        _chartView.usePercentValuesEnabled = YES;
        _chartView.drawHoleEnabled = YES;
        _chartView.holeColor = [UIColor clearColor];
        _chartView.rotationEnabled = NO;
        _chartView.entryLabelColor = [UIColor colorWithHexString:@"202020"];
        _chartView.rotationAngle = 20.f;
        _chartView.legend.enabled = NO;
        _chartView.delegate = self;
    }
    return _chartView;
}

- (void)updateData {
    self.dataArray = [RecordDao getTypeSumMoneyFrom:[DateUtils monthStartForYear:self.year month:self.month] to:[DateUtils monthEndForYear:self.year month:self.month] type:self.type];
    self.max = [self getMax:self.dataArray];
    [self.tableView reloadData];
    
    [self setMonthSumMoney];
    [self setChartMoney];
}

- (void)setMonthSumMoney {
    NSMutableArray *monthSum = [RecordDao getMonthOfYearSumMoneyFrom:[DateUtils monthStartForYear:self.year month:self.month] to:[DateUtils monthEndForYear:self.year month:self.month]];
    NSDecimalNumber *outlay = NSDecimalNumber.zero;
    NSDecimalNumber *income = NSDecimalNumber.zero;
    self.outlayBtn.hidden = YES;
    self.incomeBtn.hidden = YES;
    for (MonthSumMoneyModel *ms in monthSum) {
        if (ms.type == RecordTypeOutlay) {
            outlay = ms.sumMoney;
            [self.outlayBtn setTitle:[NSString stringWithFormat:@"%@ %@%@", NSLocalizedString(@"text_outlay", nil), [ConfigManager getCurrentSymbol], [DecimalUtils fen2Yuan:outlay]] forState:UIControlStateNormal];
            self.outlayBtn.hidden = NO;
        } else {
            income = ms.sumMoney;
            [self.incomeBtn setTitle:[NSString stringWithFormat:@"%@ %@%@", NSLocalizedString(@"text_income", nil), [ConfigManager getCurrentSymbol], [DecimalUtils fen2Yuan:income]] forState:UIControlStateNormal];
            self.incomeBtn.hidden = NO;
        }
    }
    
    if ([income compare:NSDecimalNumber.zero] == NSOrderedDescending) {
        self.overageLabel.hidden = NO;
        self.overageLabel.text = [NSString stringWithFormat:@"%@ %@%@", NSLocalizedString(@"text_overage", nil), [ConfigManager getCurrentSymbol], [DecimalUtils fen2Yuan:[income decimalNumberBySubtracting:outlay]]];
    } else {
        self.overageLabel.hidden = YES;
    }
}

- (void)setChartMoney {
    NSMutableArray<TypeSumMoneyModel *> *sumArray = [RecordDao getTypeSumMoneyFrom:[DateUtils monthStartForYear:self.year month:self.month] to:[DateUtils monthEndForYear:self.year month:self.month] type:self.type];
    if (sumArray.count != 0) {
        self.chartView.hidden = NO;
    } else {
        self.chartView.hidden = YES;
        return;
    }
    NSMutableArray<PieChartDataEntry *> *entryArray = [NSMutableArray array];
    for (TypeSumMoneyModel *model in sumArray) {
        NSDecimalNumber *money = model.typeSumMoney;
        [entryArray addObject:[[PieChartDataEntry alloc] initWithValue:money.doubleValue label:model.typeName data:model]];
    }
    
    PieChartDataSet *set1;
    if (self.chartView.data.dataSetCount > 0) {
        set1 = (PieChartDataSet *)[self.chartView.data getDataSetByIndex:0];
        set1.values = entryArray;
        set1.colors = [self colorArray];
        [self.chartView.data notifyDataChanged];
        [self.chartView notifyDataSetChanged];
    } else {
        set1 = [[PieChartDataSet alloc] initWithValues:entryArray label:@""];
        set1.sliceSpace = 0;
        set1.selectionShift = 1.2;
        set1.valueLinePart1Length = 0.2;
        set1.valueLinePart2Length = 0.4f;
        set1.xValuePosition = PieChartValuePositionOutsideSlice;
        set1.yValuePosition = PieChartValuePositionInsideSlice;
        set1.valueLineVariableLength = NO;
        set1.valueLineColor = [UIColor colorWithHexString:@"737373"];
        set1.colors = [self colorArray];
        
        NSMutableArray *dataSets = [NSMutableArray array];
        [dataSets addObject:set1];
        PieChartData *data = [[PieChartData alloc] initWithDataSets:dataSets];
        [data setValueFormatter:[PercentFormatter new]];
        [data setValueFont:[UIFont systemFontOfSize:12]];
        [data setValueTextColor:[UIColor colorWithHexString:@"202020"]];
        self.chartView.data = data;
    }
}

- (NSDecimalNumber *)getMax:(NSMutableArray *)numbers {
    NSDecimalNumber *max = NSDecimalNumber.zero;
    for (TypeSumMoneyModel *model in numbers) {
        if ([model.typeSumMoney compare:max] == NSOrderedDescending) {
            max = model.typeSumMoney;
        }
    }
    return max;
}

- (IBAction)tapOutlay:(UIButton *)sender {
    if (!sender.isSelected) {
        sender.selected = YES;
        self.incomeBtn.selected = NO;
        self.type = RecordTypeOutlay;
        [self updateData];
    }
}

- (IBAction)tapIncome:(UIButton *)sender {
    if (!sender.isSelected) {
        sender.selected = YES;
        self.outlayBtn.selected = NO;
        self.type = RecordTypeIncome;
        [self updateData];
    }
}

- (void)setYear:(NSInteger)year withMonth:(NSInteger)month {
    self.year = year;
    self.month = month;
    [self updateData];
}

- (NSInteger)year {
    if (_year == 0) {
        _year = [DateUtils currentYear];
    }
    return _year;
}

- (NSInteger)month {
    if (_month == 0) {
        _month = [DateUtils currentMonth];
    }
    return _month;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ReportViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.max = self.max;
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TypeRecordViewController *vc = [TypeRecordViewController new];
    vc.model = [self.dataArray objectAtIndex:indexPath.row];
    vc.year = self.year;
    vc.month = self.month;
    [[self controller] pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UINavigationController *)controller {
    return (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

- (void)chartValueSelected:(ChartViewBase *)chartView entry:(ChartDataEntry *)entry highlight:(ChartHighlight *)highlight {
    TypeSumMoneyModel *model = entry.data;
    TypeRecordViewController *vc = [TypeRecordViewController new];
    vc.model = model;
    vc.year = self.year;
    vc.month = self.month;
    [[self controller] pushViewController:vc animated:YES];
}

- (NSMutableArray<UIColor *> *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
        [_colorArray addObject:[UIColor colorWithHexString:@"96c6fd"]];
        [_colorArray addObject:[UIColor colorWithHexString:@"e6a239"]];
        [_colorArray addObject:[UIColor colorWithHexString:@"44cef6"]];
        [_colorArray addObject:[UIColor colorWithHexString:@"86d06d"]];
        [_colorArray addObject:[UIColor colorWithHexString:@"F9C909"]];
        [_colorArray addObject:[UIColor colorWithHexString:@"59B6DC"]];
        [_colorArray addObject:[UIColor colorWithHexString:@"e1677a"]];
    }
    return _colorArray;
}
@end

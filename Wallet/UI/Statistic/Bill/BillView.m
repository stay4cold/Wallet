//
//  BillView.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/24.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "BillView.h"
#import "AddRecordViewController.h"
#import "TimeRecordModel.h"

@implementation VFormatter

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    NSInteger v = (int)value;
    if (v >= 0) {
        return [NSString stringWithFormat:@"%ld%@", v, NSLocalizedString(@"day", nil)];
    } else {
        return @"";
    }
}

@end

@interface BillView() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *outlayBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeBtn;
@property (weak, nonatomic) IBOutlet UILabel *overageLabel;
@property (strong, nonatomic) BarChartView *chartView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<TimeRecordModel *> *dataArray;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) RecordType type;

@end

@implementation BillView

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
    self.tableView.tableHeaderView = self.chartView;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.emptyDataSetSource = self.tableView;
    self.tableView.emptyDataSetDelegate = self.tableView;
    UILabel *label = [UILabel new];
    label.text = NSLocalizedString(@"text_empty_tip", nil);
    label.textColor = [UIColor colorWithHexString:@"737373"];
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.customViewForVTEmpty = label;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [self updateData];
}

- (BarChartView *)chartView {
    if (!_chartView) {
        _chartView = [[BarChartView alloc] initWithFrame:CGRectMake(0, 0, self.width, 180)];
        _chartView.noDataText = @"";
        _chartView.scaleXEnabled = NO;
        _chartView.scaleYEnabled = NO;
        _chartView.leftAxis.axisMinimum = 0;
        _chartView.leftAxis.enabled = NO;
        _chartView.rightAxis.enabled = NO;
        _chartView.chartDescription.enabled = NO;
        _chartView.legend.enabled = NO;
        //    self.chartView.drawValueAboveBarEnabled = YES;
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.drawGridLinesEnabled = NO;
        xAxis.labelTextColor = [UIColor colorWithHexString:@"737373"];
        xAxis.labelCount = 5;
        xAxis.valueFormatter = [VFormatter new];
    }
    return _chartView;
}

- (void)updateData {
    NSMutableArray *arr = [RecordDao getRangeRecordWithTypesFrom:[DateUtils monthStartForYear:self.year month:self.month] to:[DateUtils monthEndForYear:self.year month:self.month] type:self.type];
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
    NSMutableArray<DaySumMoneyModel *> *sumArray = [RecordDao getDaySumMoneyFrom:[DateUtils monthStartForYear:self.year month:self.month] to:[DateUtils monthEndForYear:self.year month:self.month] type:self.type];
    if (sumArray.count != 0) {
        self.tableView.tableHeaderView = self.chartView;
    } else {
        self.tableView.tableHeaderView = nil;
        return;
    }
    NSMutableArray<BarChartDataEntry *> *entryArray = [NSMutableArray array];
    BarChartDataEntry *entry;
    NSInteger count = [DateUtils dayCountForYear:self.year month:self.month];
    NSDecimalNumber *max = [self getMax:sumArray];
    for (NSInteger i = 0; i < count; i++) {
        for (DaySumMoneyModel *model in sumArray) {
            NSInteger day = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:model.time];
            if (i + 1 == day) {
                NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
                NSDecimalNumber *y = [[max decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"10"] withBehavior:handler] decimalNumberByAdding:model.daySumMoney];
                entry = [[BarChartDataEntry alloc] initWithX:(i + 1) y:[y doubleValue] data:model.daySumMoney];
                break;
            }
        }
        if (entry == nil) {
            entry = [[BarChartDataEntry alloc] initWithX:(i+1) y:0];
        }
        [entryArray addObject:entry];
        entry = nil;
    }
    
    BarChartDataSet *set1;
    if (self.chartView.data.dataSetCount > 0) {
        set1 = (BarChartDataSet *)[self.chartView.data getDataSetByIndex:0];
        set1.values = entryArray;
        [self.chartView.data notifyDataChanged];
        [self.chartView notifyDataSetChanged];
    } else {
        set1 = [[BarChartDataSet alloc] initWithValues:entryArray label:@""];
        set1.drawIconsEnabled = NO;
        set1.drawValuesEnabled = NO;
        [set1 setColor:ColorPrimary];
        set1.highlightAlpha = 0.3f;
        
        NSMutableArray *dataSets = [NSMutableArray array];
        [dataSets addObject:set1];
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        data.barWidth = 0.5f;
        data.highlightEnabled = NO;
        self.chartView.data = data;
    }
//    [self.chartView setNeedsLayout];
//    [self.chartView layoutIfNeeded];
//    [self.chartView animateWithYAxisDuration:1000];
}

- (NSDecimalNumber *)getMax:(NSMutableArray *)numbers {
    NSDecimalNumber *max = NSDecimalNumber.zero;
    for (DaySumMoneyModel *model in numbers) {
        if ([model.daySumMoney compare:max] == NSOrderedDescending) {
            max = model.daySumMoney;
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

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(ws);
    RecordWithTypeModel *record = [[self.dataArray objectAtIndex:indexPath.section].records objectAtIndex:indexPath.row];
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:NSLocalizedString(@"text_delete", nil) handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@(%@%@)", record.recordTypes[0].name,[ConfigManager getCurrentSymbol], [DecimalUtils fen2Yuan:record.money]] message:NSLocalizedString(@"text_delete_record_note", nil) preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"text_affirm", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [RecordDao deleteRecord:record];
            [ws updateData];
        }]];
        [ac addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"text_cancel", nil) style:UIAlertActionStyleCancel handler:nil]];
        [[ws controller] presentViewController:ac animated:YES completion:nil];
    }];
    return @[delete];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor colorWithHexString:@"737373"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataArray objectAtIndex:section].title;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = [[self.dataArray objectAtIndex:indexPath.section].records objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataArray objectAtIndex:section].records count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddRecordViewController *avc = [AddRecordViewController new];
    avc.recordWithType = [[self.dataArray objectAtIndex:indexPath.section].records objectAtIndex:indexPath.row];
    [((UINavigationController *)[self controller]) pushViewController:avc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIViewController *)controller {
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end

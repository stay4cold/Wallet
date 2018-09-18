//
//  AddRecordViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/13.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AddRecordViewController.h"
#import "AddTypePageView.h"
#import "RecordTypeDao.h"
#import "KeyboardView.h"

@interface AddRecordViewController () <KeyboardViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *typeControl;
@property (weak, nonatomic) IBOutlet AddTypePageView *outlayTypePageView;
@property (weak, nonatomic) IBOutlet AddTypePageView *incomeTypePageView;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UITextField *remarkField;
@property (weak, nonatomic) IBOutlet UILabel *assetsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *assetsImgView;
@property (weak, nonatomic) IBOutlet KeyboardView *keyboardView;

@end

@implementation AddRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isSuccessive) {
        self.title = @"记一笔(连续)";
    } else {
        self.title = @"记一笔";
    }
    
    if (!self.record) {
        self.title = @"修改";
    }
    
    self.outlayTypePageView.type = RecordTypeOutlay;
    self.outlayTypePageView.dataArray = [RecordTypeDao getAllRecordTypes];
    self.incomeTypePageView.type = RecordTypeIncome;
    self.incomeTypePageView.dataArray = [RecordTypeDao getAllRecordTypes];
    
    self.keyboardView.delegate = self;
}

- (IBAction)typeChanged:(UISegmentedControl *)sender {
    self.outlayTypePageView.hidden = sender.selectedSegmentIndex == 1;
    self.incomeTypePageView.hidden = sender.selectedSegmentIndex == 0;
}

- (IBAction)tapDateBtn:(UIButton *)sender {
}

- (void)keyboardView:(KeyboardView *)keyboard confirm:(NSString *)text {
    
}

@end

//
//  AddTypeViewController.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "AddTypeViewController.h"
#import "AddTypeViewCell.h"
#import "RecordTypeDao.h"
#import "RecordModel.h"
#import "RecordDao.h"

@interface AddTypeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UITextField *typeField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger checkedPosition;

@property (nonatomic, copy) NSString *checkedImageName;
@property (nonatomic, strong) NSNumber *ranking;

@end

@implementation AddTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"text_save", nil) style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    if (self.model) {
        if (self.model.type == RecordTypeOutlay) {
            self.title = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"text_modify", nil), NSLocalizedString(@"text_outlay_type", nil)];
        } else {
            self.title = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"text_modify", nil), NSLocalizedString(@"text_income_type", nil)];
        }
        self.type = self.model.type;
        for (NSInteger i = 0; i < self.dataArray.count; i++) {
            if ([[self.dataArray objectAtIndex:i] isEqualToString:self.model.img_name]) {
                break;
            } else {
                self.checkedPosition++;
            }
        }
    } else {
        if (self.type == RecordTypeOutlay) {
            self.title = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"text_add", nil), NSLocalizedString(@"text_outlay_type", nil)];
        } else {
            self.title = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"text_add", nil), NSLocalizedString(@"text_income_type", nil)];
        }
    }
    [self updateTypeImage];
    self.typeField.text = self.model.name;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([AddTypeViewCell class]) bundle:nil]  forCellWithReuseIdentifier:@"cell"];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:[RecordTypeDao getAllRecordTypeImgs:self.type]];
    }
    return _dataArray;
}

- (void)updateTypeImage {
    self.typeImageView.image = [UIImage imageNamed:self.checkedImageName];
}

- (NSString *)checkedImageName {
    return [self.dataArray objectAtIndex:self.checkedPosition];
}

- (NSNumber *)ranking {
    return [NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]];
}

- (void)save {
    NSString *name = [self.typeField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (name.length == 0) {
        [self showHUDInView:self.view justWithText:NSLocalizedString(@"hint_enter_type_name", nil) disMissAfterDelay:2];
    } else {
        if (self.model) {//修改
            RecordTypeModel *newModel = [RecordTypeModel recordTypeWithModel:self.model];
            newModel.name = name;
            newModel.img_name = self.checkedImageName;
            
            if (![self.model.name isEqualToString:name]) {
                RecordTypeModel *dbModel = [RecordTypeDao getRecordType:self.type byName:name];
                if (dbModel) {
                    if (dbModel.state == RecordStateDeleted) {
                        dbModel.state = RecordStateNormal;
                        dbModel.name = name;
                        dbModel.img_name = self.checkedImageName;
                        dbModel.ranking = self.ranking;
                        [RecordTypeDao updateRecordTypes:[NSMutableArray arrayWithObject:dbModel]];
                        //更新之前关联到已删除的type的record
                        NSMutableArray *records = [RecordDao getRecordsWithTypeId:self.model.ID];
                        if (records.count > 0) {
                            for (RecordModel *record in records) {
                                record.record_type_id = dbModel.ID;
                            }
                            [RecordDao updateRecords:records];
                        }
                        [RecordTypeDao deleteRecordType:self.model];
                    } else {
                        [self showHUDInView:self.view justWithText:[NSString stringWithFormat:@"%@ %@", name, NSLocalizedString(@"toast_type_is_exist", nil)] disMissAfterDelay:2];
                        return;
                    }
                } else {
                    [RecordTypeDao updateRecordTypes:[NSMutableArray arrayWithObject:newModel]];
                }
            } else if (![self.model.img_name isEqualToString:self.checkedImageName]) {
                [RecordTypeDao updateRecordTypes:[NSMutableArray arrayWithObject:newModel]];
            }
            [self.navigationController popViewControllerAnimated:YES];
        } else {//新建
            RecordTypeModel *dbModel = [RecordTypeDao getRecordType:self.type byName:name];
            if (dbModel) {//已经存在name
                if (dbModel.state == RecordStateDeleted) {//删除状态
                    dbModel.state = RecordStateNormal;
                    dbModel.img_name = [self.dataArray objectAtIndex:self.checkedPosition];
                    dbModel.ranking = self.ranking;
                    [RecordTypeDao updateRecordTypes:[NSMutableArray arrayWithObject:dbModel]];
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    [self showHUDInView:self.view justWithText:[NSString stringWithFormat:@"%@ %@", name, NSLocalizedString(@"toast_type_is_exist", nil)] disMissAfterDelay:2];
                }
            } else {//不存在直接新增
                dbModel = [RecordTypeModel new];
                dbModel.name = name;
                dbModel.img_name = self.checkedImageName;
                dbModel.type = self.type;
                dbModel.ranking = self.ranking;
                [RecordTypeDao insertRecordTypes:[NSMutableArray arrayWithObject:dbModel]];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.checkedPosition = indexPath.row;
    [collectionView reloadData];
    [self updateTypeImage];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.frame.size.width / 4;
    return CGSizeMake(width, width);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddTypeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imgName = [self.dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == self.checkedPosition) {
        cell.checked = YES;
    } else {
        cell.checked = NO;
    }
    return cell;
}

@end

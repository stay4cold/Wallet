//
//  AddTypePageViewCell.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/17.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordTypeModel.h"

@protocol AddTypePageViewCellDelegate <NSObject>

- (void)didSelectItemModel:(RecordTypeModel *)model atIndexPath:(NSIndexPath *)indexPath;

@end

@interface AddTypePageViewCell : UICollectionViewCell

@property (nonatomic, strong) NSMutableArray<RecordTypeModel *> *dataArray;
@property (nonatomic, weak) id<AddTypePageViewCellDelegate> delegate;

@end

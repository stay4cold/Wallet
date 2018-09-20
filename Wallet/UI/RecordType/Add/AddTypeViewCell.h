//
//  AddTypeViewCell.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTypeViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *imgName;
@property (nonatomic, assign, getter=isChecked) BOOL checked;

@end

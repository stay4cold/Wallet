//
//  TypeTableView.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/18.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeTableView : UIView

@property (nonatomic, assign) RecordType type;

- (void)startOrder;
- (void)endOrder;

@end

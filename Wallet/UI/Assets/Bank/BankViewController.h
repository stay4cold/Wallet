//
//  BankViewController.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankCreator.h"
#import "TypeTableViewCell.h"

@protocol BankViewDelegate <NSObject>

- (void)bankViewSelect:(BankModel *)bank;

@end

@interface BankViewController : UITableViewController

@property (nonatomic, weak) id<BankViewDelegate> delegate;

@end

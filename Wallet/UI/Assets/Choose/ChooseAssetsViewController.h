//
//  ChooseAssetsViewController.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseAssetsViewCell.h"
#import "AssetsDao.h"
#import "AllAssetsViewController.h"

@protocol ChooseAssetsDelegate <NSObject>

- (void)chooseAssets:(AssetsModel *)assets;

@end

@interface ChooseAssetsViewController : UITableViewController

@property (nonatomic, weak) id<ChooseAssetsDelegate> delegate;

@end

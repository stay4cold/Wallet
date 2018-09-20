//
//  AddAssetsViewController.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/19.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetsTypeModel.h"
#import "AssetsModel.h"

@interface AddAssetsViewController : UIViewController

@property (nonatomic, strong) AssetsTypeModel *assetsTypeModel;
@property (nonatomic, strong) AssetsModel *assetsModel;
@end

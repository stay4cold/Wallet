//
//  SettingViewController.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/21.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

+ (NormalItem *)normalTitle:(NSString *)title content:(NSString *)content;

@end

@interface CheckItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign, getter=isChecked) BOOL checked;

+ (CheckItem *)itemTitle:(NSString *)title content:(NSString *)content check:(BOOL)checked;

@end

@interface SettingViewController : UITableViewController

@end

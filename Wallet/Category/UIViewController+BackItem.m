//
//  UIViewController+BackItem.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/24.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "UIViewController+BackItem.h"
#import <objc/runtime.h>

@implementation UIViewController (BackItem)

+ (void)load {
    Method viewDidLoadMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method newViewDidLoadMethod = class_getInstanceMethod([self class], @selector(evan_viewDidLoad));
    method_exchangeImplementations(viewDidLoadMethod, newViewDidLoadMethod);
}

- (void)evan_viewDidLoad {
    [self evan_viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"text_return", nil) style:UIBarButtonItemStyleDone target:nil action:nil];
}

@end

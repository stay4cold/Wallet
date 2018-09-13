//
//  NSObject+HUD.h
//  New Orient
//
//  Created by apple on 14-12-3.
//  Copyright (c) 2014年 nding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HUD)

- (void)hideHUD;

- (void)showHUDInWindowWithText:(NSString *)text;
- (void)showHUDInWindowWithText:(NSString *)text disMissAfterDelay:(NSTimeInterval)delay;
- (void)showHUDInWindowJustWithText:(NSString *)text;
- (void)showHUDInWindowJustWithText:(NSString *)text disMissAfterDelay:(NSTimeInterval)delay;

- (void)showHUDInView:(UIView *)view WithText:(NSString *)text;
- (void)showHUDInView:(UIView *)view WithText:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay;
- (void)showHUDInView:(UIView *)view justWithText:(NSString *)text;
- (void)showHUDInView:(UIView *)view justWithText:(NSString *)text disMissAfterDelay:(NSTimeInterval)delay;

- (void)showHUDWithCustomView:(UIView *)customView inView:(UIView *)view;

@end

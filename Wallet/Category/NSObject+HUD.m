//
//  NSObject+HUD.m
//  New Orient
//
//  Created by apple on 14-12-3.
//  Copyright (c) 2014年 nding. All rights reserved.
//

#import "NSObject+HUD.h"

static MBProgressHUD *__HUD = nil;

#define KeyWindow     [[UIApplication sharedApplication] keyWindow]


@implementation NSObject (HUD)

- (void)hideHUD {
    [__HUD hideAnimated:YES];
}

- (void)showHUDInWindowWithText:(NSString *)text {
    [__HUD hideAnimated:YES afterDelay:0.3];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:KeyWindow animated:YES];
    HUD.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    __HUD = HUD ;
    if (text) {
        HUD.label.text = text;
    }
}

- (void)showHUDInWindowWithText:(NSString *)text disMissAfterDelay:(NSTimeInterval)delay {
    [self showHUDInWindowWithText:text];
    [__HUD hideAnimated:YES afterDelay:delay];
}

- (void)showHUDInWindowJustWithText:(NSString *)text {
    [__HUD hideAnimated:YES afterDelay:0.3];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:KeyWindow animated:YES];
    HUD.mode = MBProgressHUDModeText;
    HUD.offset = CGPointMake(0, MBProgressMaxOffset);
    if (text) {
        HUD.detailsLabel.text = text;
    }
    __HUD = HUD;
}

- (void)showHUDInWindowJustWithText:(NSString *)text disMissAfterDelay:(NSTimeInterval)delay {
    [self showHUDInWindowJustWithText:text];
    [__HUD hideAnimated:YES afterDelay:delay];
}

- (void)showHUDInView:(UIView *)view WithText:(NSString *)text {
    [__HUD hideAnimated:YES afterDelay:0.3];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    HUD.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    if (text) {
        HUD.label.text = text;
    }
    __HUD = HUD;
}

- (void)showHUDInView:(UIView *)view WithText:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay {
    [self showHUDInView:view WithText:text];
    [__HUD hideAnimated:YES afterDelay:delay];
}

- (void)showHUDInView:(UIView *)view justWithText:(NSString *)text {
    [__HUD hideAnimated:YES afterDelay:0.3];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeText;
    if (text) {
        HUD.detailsLabel.text = text;
    }
    __HUD = HUD;
}

- (void)showHUDInView:(UIView *)view justWithText:(NSString *)text disMissAfterDelay:(NSTimeInterval)delay {
    [self showHUDInView:view justWithText:text];
    [__HUD hideAnimated:YES afterDelay:delay];
}

- (void)showHUDWithCustomView:(UIView *)customView inView:(UIView *)view {
    UIControl *overView = [[UIControl alloc] initWithFrame:view.bounds];
    overView.backgroundColor = [UIColor clearColor];
    [overView addTarget:self action:@selector(overViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect frame = view.bounds;
    customView.center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2);
    [overView addSubview:customView];
    [view addSubview:overView];
    
    
    overView.alpha = 0;
    [UIView animateWithDuration:.3 animations:^{
        overView.alpha = 1.0;
    }];
}

- (void)overViewClicked:(id)sender {
    UIControl *ct = (UIControl *)sender;
    [UIView animateWithDuration:.5
                     animations:^{
                         ct.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [ct removeFromSuperview];
                     }];
}


@end

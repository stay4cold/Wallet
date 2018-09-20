//
//  KeyboardView.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/15.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyboardView;
@protocol KeyboardViewDelegate <NSObject>

- (void)keyboardView:(KeyboardView *)keyboard confirm:(NSString *)text;

@end

@interface KeyboardView : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, weak) id<KeyboardViewDelegate> delegate;

@end

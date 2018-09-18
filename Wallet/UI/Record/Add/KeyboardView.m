//
//  KeyboardView.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/15.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "KeyboardView.h"

@interface KeyboardView()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation KeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustom];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initCustom];
    }
    return self;
}

- (void)initCustom {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.contentView];
    self.contentView.frame = self.bounds;
    //拦截系统键盘
    self.amountField.inputView = [UIView new];
    [self.backBtn addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(backLongGesture:)]];
}

- (IBAction)btnTap:(UIButton *)sender {
    NSString *btnText = [sender titleForState:UIControlStateNormal];
    NSString *fieldText = self.amountField.text;
    if (btnText.length == 0 ) {
        if (fieldText.length > 0) {
            self.amountField.text = [fieldText substringToIndex:(fieldText.length - 1)];
        }
    } else if (btnText.length == 1) {
        self.amountField.text = [self append:fieldText with:btnText];
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardView:confirm:)]) {
            [self.delegate keyboardView:self confirm:fieldText];
        }
    }
}

- (NSString *)append:(NSString *)text with:(NSString *)input {
    if (text.length == 0) {
        if ([@"." isEqualToString:input]) {
            return @"0.";
        } else {
            return input;
        }
    } else if (text.length == 1) {
        if ([text hasPrefix:@"0"]) {
            if ([@"." isEqualToString:input]) {
                return [text stringByAppendingString:input];
            } else {
                return input;
            }
        } else {
            return [text stringByAppendingString:input];
        }
    } else if ([text containsString:@"."]) {
        if (![@"." isEqualToString:input] && (text.length - [text rangeOfString:@"."].location < 3)) {
            return [text stringByAppendingString:input];
        }
    } else {
        return [text stringByAppendingString:input];
    }
    return text;
}

//长按清空
- (void)backLongGesture:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.amountField.text = @"";
    }
}

@end

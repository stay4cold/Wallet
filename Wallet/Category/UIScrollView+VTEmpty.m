//
//  UIScrollView+VTEmpty.m
//  Vanthink_tea
//
//  Created by 王成浩 on 2018/6/22.
//  Copyright © 2018年 MacBook. All rights reserved.
//

#import "UIScrollView+VTEmpty.h"

@implementation UIScrollView (VTEmpty)

- (void (^)(id))emptyTap {
    return objc_getAssociatedObject(self, @selector(emptyTap));
}

- (void)setEmptyTap:(void (^)(id))emptyTap {
    objc_setAssociatedObject(self, @selector(emptyTap), emptyTap, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIView *))emptyTapView {
    return objc_getAssociatedObject(self, @selector(emptyTapView));
}

- (void)setEmptyTapView:(void (^)(UIView *))emptyTapView {
    objc_setAssociatedObject(self, @selector(emptyTapView), emptyTapView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *))emptyTapButton {
    return objc_getAssociatedObject(self, @selector(emptyTapButton));
}

- (void)setEmptyTapButton:(void (^)(UIButton *))emptyTapButton {
    objc_setAssociatedObject(self, @selector(emptyTapButton), emptyTapButton, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)initAndReload {
    if (!self.emptyDataSetDelegate) {
        self.emptyDataSetDelegate = self;
    }
    if (!self.emptyDataSetSource) {
        self.emptyDataSetSource = self;
    }
    [self reloadEmptyDataSet];
}

- (BOOL)loading {
    NSNumber *visible = objc_getAssociatedObject(self, @selector(loading));
    return [visible boolValue];
}

- (void)setLoading:(BOOL)loading {
    if (self.loading == loading) {
        return;
    }
    objc_setAssociatedObject(self, @selector(loading), [NSNumber numberWithBool:loading], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self initAndReload];
}

- (NSAttributedString *)titleAttributedForVTEmpty {
    return objc_getAssociatedObject(self, @selector(titleAttributedForVTEmpty));
}

- (void)setTitleAttributedForVTEmpty:(NSAttributedString *)titleAttributedForVTEmpty {
    objc_setAssociatedObject(self, @selector(titleAttributedForVTEmpty), titleAttributedForVTEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)titleForVTEmpty {
    return objc_getAssociatedObject(self, @selector(titleForVTEmpty));
}

- (void)setTitleForVTEmpty:(NSString *)titleForVTEmpty {
    objc_setAssociatedObject(self, @selector(titleForVTEmpty), titleForVTEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSAttributedString *)descriptionAttributedForVTEmpty {
    return objc_getAssociatedObject(self, @selector(descriptionAttributedForVTEmpty));
}

- (void)setDescriptionAttributedForVTEmpty:(NSAttributedString *)descriptionAttributedForVTEmpty {
    objc_setAssociatedObject(self, @selector(descriptionAttributedForVTEmpty), descriptionAttributedForVTEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)descriptionForVTEmpty {
    return objc_getAssociatedObject(self, @selector(descriptionForVTEmpty));
}

- (void)setDescriptionForVTEmpty:(NSString *)descriptionForVTEmpty {
    objc_setAssociatedObject(self, @selector(descriptionForVTEmpty), descriptionForVTEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImage *)imageForVTEmpty {
    return objc_getAssociatedObject(self, @selector(imageForVTEmpty));
}

- (void)setImageForVTEmpty:(UIImage *)imageForVTEmpty {
    objc_setAssociatedObject(self, @selector(imageForVTEmpty), imageForVTEmpty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)imageTintColorForVTEmpty {
    return objc_getAssociatedObject(self, @selector(imageTintColorForVTEmpty));
}

- (void)setImageTintColorForVTEmpty:(UIColor *)imageTintColorForVTEmpty {
    objc_setAssociatedObject(self, @selector(imageTintColorForVTEmpty), imageTintColorForVTEmpty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAAnimation *)imageAnimationForVTEmpty {
    return objc_getAssociatedObject(self, @selector(imageAnimationForVTEmpty));
}

- (void)setImageAnimationForVTEmpty:(CAAnimation *)imageAnimationForVTEmpty {
    objc_setAssociatedObject(self, @selector(imageAnimationForVTEmpty), imageAnimationForVTEmpty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSAttributedString *)buttonTitleAttributedForVTEmpty {
    return objc_getAssociatedObject(self, @selector(buttonTitleAttributedForVTEmpty));
}

- (void)setButtonTitleAttributedForVTEmpty:(NSAttributedString *)buttonTitleAttributedForVTEmpty {
    objc_setAssociatedObject(self, @selector(buttonTitleAttributedForVTEmpty), buttonTitleAttributedForVTEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)buttonTitleForVTEmpty {
    return objc_getAssociatedObject(self, @selector(buttonTitleForVTEmpty));
}

- (void)setButtonTitleForVTEmpty:(NSString *)buttonTitleForVTEmpty {
    objc_setAssociatedObject(self, @selector(buttonTitleForVTEmpty), buttonTitleForVTEmpty, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImage *)buttonImageForVTEmpty {
    return objc_getAssociatedObject(self, @selector(buttonImageForVTEmpty));
}

- (void)setButtonImageForVTEmpty:(UIImage *)buttonImageForVTEmpty {
    objc_setAssociatedObject(self, @selector(buttonImageForVTEmpty), buttonImageForVTEmpty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)buttonBackgroundImageForVTEmpty {
    return objc_getAssociatedObject(self, @selector(buttonBackgroundImageForVTEmpty));
}

- (void)setButtonBackgroundImageForVTEmpty:(UIImage *)buttonBackgroundImageForVTEmpty {
    objc_setAssociatedObject(self, @selector(buttonBackgroundImageForVTEmpty), buttonBackgroundImageForVTEmpty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)buttonBackgroundColorForVTEmpty {
    return objc_getAssociatedObject(self, @selector(buttonBackgroundColorForVTEmpty));
}

- (void)setButtonBackgroundColorForVTEmpty:(UIColor *)buttonBackgroundColorForVTEmpty {
    objc_setAssociatedObject(self, @selector(buttonBackgroundColorForVTEmpty), buttonBackgroundColorForVTEmpty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)customViewForVTEmpty {
    return objc_getAssociatedObject(self, @selector(customViewForVTEmpty));
}

- (void)setCustomViewForVTEmpty:(UIView *)customViewForVTEmpty {
    objc_setAssociatedObject(self, @selector(customViewForVTEmpty), customViewForVTEmpty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)verticalOffsetForVTEmpty {
    NSNumber *offset = objc_getAssociatedObject(self, @selector(verticalOffsetForVTEmpty));
    return [offset floatValue];
}

- (void)setVerticalOffsetForVTEmpty:(CGFloat)verticalOffsetForVTEmpty {
    objc_setAssociatedObject(self, @selector(verticalOffsetForVTEmpty), [NSNumber numberWithFloat:verticalOffsetForVTEmpty], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)spaceHeightForVTEmpty {
    NSNumber *height = objc_getAssociatedObject(self, @selector(spaceHeightForVTEmpty));
    return [height floatValue];
}

- (void)setSpaceHeightForVTEmpty:(CGFloat)spaceHeightForVTEmpty {
    objc_setAssociatedObject(self, @selector(spaceHeightForVTEmpty), [NSNumber numberWithFloat:spaceHeightForVTEmpty], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - DZNEmptyDataSetDelegate
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return !self.loading;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.emptyTapView) {
        self.emptyTapView(view);
    } else if (self.emptyTap) {
        self.emptyTap(view);
    }
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.emptyTapButton) {
        self.emptyTapButton(button);
    } else if (self.emptyTap) {
        self.emptyTap(button);
    }
}

#pragma mark - DZNEmptyDataSetSource
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.titleAttributedForVTEmpty) {
        return self.titleAttributedForVTEmpty;
    }
    if (self.titleForVTEmpty) {
        UIFont *font = [UIFont systemFontOfSize:17];
        UIColor *textColor = [UIColor grayColor];
        return [[NSAttributedString alloc] initWithString:self.titleForVTEmpty attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:textColor}];
    }
    
    return nil;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.descriptionAttributedForVTEmpty) {
        return self.descriptionAttributedForVTEmpty;
    }
    if (self.descriptionForVTEmpty) {
        UIFont *font = [UIFont systemFontOfSize:17];
        UIColor *textColor = [UIColor grayColor];
        return [[NSAttributedString alloc] initWithString:self.descriptionForVTEmpty attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:textColor}];
    }
    
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return self.imageForVTEmpty;
}

- (nullable UIColor *)imageTintColorForEmptyDataSet:(UIScrollView *)scrollView {
    return self.imageTintColorForVTEmpty;
}

- (nullable CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    return self.imageAnimationForVTEmpty;
}

- (nullable NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.buttonTitleAttributedForVTEmpty) {
        return self.buttonTitleAttributedForVTEmpty;
    }
    if (!self.buttonTitleForVTEmpty) {
        self.buttonTitleForVTEmpty = @"点击重新加载";
    }
    if (self.buttonTitleForVTEmpty) {
        UIFont *font = [UIFont systemFontOfSize:17];
        UIColor *textColor = [UIColor blueColor];
        return [[NSAttributedString alloc] initWithString:self.buttonTitleForVTEmpty attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:textColor}];
    }
    
    return nil;
}

- (nullable UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return self.buttonImageForVTEmpty;
}

- (nullable UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return self.buttonBackgroundImageForVTEmpty;
}

- (nullable UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return self.buttonBackgroundColorForVTEmpty;
}

- (nullable UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.loading) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicator startAnimating];
        return indicator;
    }
    return self.customViewForVTEmpty;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.verticalOffsetForVTEmpty;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return self.spaceHeightForVTEmpty;
}

@end

//
//  UIScrollView+VTEmpty.h
//  Vanthink_tea
//
//  Created by 王成浩 on 2018/6/22.
//  Copyright © 2018年 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "objc/runtime.h"
#import "UIScrollView+EmptyDataSet.h"

@interface UIScrollView (VTEmpty) <DZNEmptyDataSetDelegate, DZNEmptyDataSetSource>

@property (nonatomic, assign) BOOL loading;

//空白视图点击block
@property (nonatomic, copy) void (^emptyTap)(id sender);
//View回调
@property (nonatomic, copy) void (^emptyTapView)(UIView *view);
//Button回调
@property (nonatomic, copy) void (^emptyTapButton)(UIButton *button);

@property (nonatomic, copy) NSAttributedString *titleAttributedForVTEmpty;
@property (nonatomic, copy) NSString *titleForVTEmpty;
@property (nonatomic, copy) NSAttributedString *descriptionAttributedForVTEmpty;
@property (nonatomic, copy) NSString *descriptionForVTEmpty;
@property (nonatomic, strong) UIImage *imageForVTEmpty;
@property (nonatomic, strong) UIColor *imageTintColorForVTEmpty;
@property (nonatomic, strong) CAAnimation *imageAnimationForVTEmpty;
@property (nonatomic, copy) NSAttributedString *buttonTitleAttributedForVTEmpty;
@property (nonatomic, copy) NSString *buttonTitleForVTEmpty;
@property (nonatomic, strong) UIImage *buttonImageForVTEmpty;
@property (nonatomic, strong) UIImage *buttonBackgroundImageForVTEmpty;
@property (nonatomic, strong) UIColor *buttonBackgroundColorForVTEmpty;
@property (nonatomic, strong) UIView *customViewForVTEmpty;
@property (nonatomic, assign) CGFloat verticalOffsetForVTEmpty;
@property (nonatomic, assign) CGFloat spaceHeightForVTEmpty;

@end

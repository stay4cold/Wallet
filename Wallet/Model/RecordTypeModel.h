//
//  RecordTypeModel.h
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordTypeModel : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img_name;
@property (nonatomic, assign) RecordType type;
@property (nonatomic, strong) NSNumber *ranking;//排序
@property (nonatomic, assign) RecordState state;

@property (nonatomic, assign, getter=isChecked) BOOL checked;
@property (nonatomic, assign, getter=isSetting) BOOL setting;

@end

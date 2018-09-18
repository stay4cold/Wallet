//
//  RecordTypeModel.m
//  Wallet
//
//  Created by 王成浩 on 2018/9/14.
//  Copyright © 2018年 evan. All rights reserved.
//

#import "RecordTypeModel.h"

@implementation RecordTypeModel

- (instancetype) initWithId:(NSNumber *)ID name:(NSString *)name imgName:(NSString *)imgName type:(RecordType)type ranking:(NSNumber *)ranking state:(RecordState)state {
    if (self = [super init]) {
        self.ID = ID;
        self.name = name;
        self.img_name = imgName;
        self.type = type;
        self.ranking = ranking;
        self.state = state;
    }
    return self;
}

+ (instancetype)recordTypeWithModel:(RecordTypeModel *)model {
    return [[self alloc] initWithId:model.ID name:model.name imgName:model.img_name type:model.type ranking:model.ranking state:model.state];
}

@end

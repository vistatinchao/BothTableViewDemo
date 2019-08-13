//
//  ZCTagModel.m
//  BothTableViewDemo
//
//  Created by zouchao on 2019/8/13.
//  Copyright © 2019 zouchao. All rights reserved.
//

#import "ZCTagModel.h"

@implementation ZCTagModel

- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end

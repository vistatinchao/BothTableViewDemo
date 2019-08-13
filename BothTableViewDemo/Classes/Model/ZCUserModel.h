//
//  ZCUserModel.h
//  BothTableViewDemo
//
//  Created by zouchao on 2019/8/13.
//  Copyright © 2019 zouchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCUserModel : NSObject
/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数(有多少人关注这个用户) */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;


@end

NS_ASSUME_NONNULL_END

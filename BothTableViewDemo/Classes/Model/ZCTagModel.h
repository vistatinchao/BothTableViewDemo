//
//  ZCTagModel.h
//  BothTableViewDemo
//
//  Created by zouchao on 2019/8/13.
//  Copyright © 2019 zouchao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCTagModel : NSObject

/**name*/
@property (nonatomic ,copy) NSString *name;
/**id*/
@property (nonatomic,assign) NSInteger id;
/**count*/
@property (nonatomic,assign) NSInteger count;


@end

NS_ASSUME_NONNULL_END

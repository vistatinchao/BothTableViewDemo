//
//  ZCTagCell.h
//  BothTableViewDemo
//
//  Created by zouchao on 2019/8/13.
//  Copyright © 2019 zouchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCTagModel;
NS_ASSUME_NONNULL_BEGIN

@interface ZCTagCell : UITableViewCell
/**tagModel*/
@property (nonatomic,strong) ZCTagModel *tagModel;
@end

NS_ASSUME_NONNULL_END

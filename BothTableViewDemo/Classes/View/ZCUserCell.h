//
//  ZCUserCell.h
//  BothTableViewDemo
//
//  Created by zouchao on 2019/8/13.
//  Copyright © 2019 zouchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCUserModel;
NS_ASSUME_NONNULL_BEGIN

@interface ZCUserCell : UITableViewCell
/**user*/
@property (nonatomic,strong) ZCUserModel *userModel;
@end

NS_ASSUME_NONNULL_END

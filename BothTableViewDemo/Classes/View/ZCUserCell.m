//
//  ZCUserCell.m
//  BothTableViewDemo
//
//  Created by zouchao on 2019/8/13.
//  Copyright © 2019 zouchao. All rights reserved.
//

#import "ZCUserCell.h"
#import "ZCUserModel.h"
#import <UIImageView+WebCache.h>
@interface ZCUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *fanceLab;

@end
@implementation ZCUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUserModel:(ZCUserModel *)userModel {
    _userModel = userModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.header]];
    self.nameLab.text = userModel.screen_name;
    self.fanceLab.text = [NSString stringWithFormat:@"%zd人关注",userModel.fans_count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

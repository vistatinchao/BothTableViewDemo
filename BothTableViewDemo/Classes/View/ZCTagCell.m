//
//  ZCTagCell.m
//  BothTableViewDemo
//
//  Created by zouchao on 2019/8/13.
//  Copyright © 2019 zouchao. All rights reserved.
//

#import "ZCTagCell.h"
#import "ZCTagModel.h"

@interface ZCTagCell()
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@end

@implementation ZCTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.indicatorView.hidden = !selected;
    self.textLabel.textColor = selected?self.indicatorView.backgroundColor:[UIColor lightGrayColor];
}

- (void)setTagModel:(ZCTagModel *)tagModel {
    _tagModel = tagModel;
    self.textLabel.text = tagModel.name;
}
@end

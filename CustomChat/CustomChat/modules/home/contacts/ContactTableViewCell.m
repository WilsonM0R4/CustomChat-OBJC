//
//  ContactTableViewCell.m
//  CustomChat
//
//  Created by Wilson Mora on 12/7/16.
//  Copyright © 2016 WilsonApps. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

@synthesize titleLabel = _titleLabel;
@synthesize subtitleLabel = _subtitleLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

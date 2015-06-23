//
//  UserTableViewCell.m
//  reservation
//
//  Created by 王晓娜 on 15/6/23.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.iconImageView = [[EGOImageView alloc]initWithPlaceholderImage:[UIImage imageNamed:@"contacts_user_avatar_default_l.png"]];
    [self.iconImageView setFrame:CGRectMake(15, 7, 45, 45)];
    [self.contentView addSubview:self.iconImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  UserTableViewCell.h
//  reservation
//
//  Created by iOS开发 on 15/6/23.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell
@property(strong,nonatomic)EGOImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

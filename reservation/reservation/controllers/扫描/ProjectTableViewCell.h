//
//  ProjectTableViewCell.h
//  reservation
//
//  Created by 王晓娜 on 15/6/17.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;
@property (weak, nonatomic) IBOutlet UILabel *cishuLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

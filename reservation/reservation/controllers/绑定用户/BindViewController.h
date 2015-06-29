//
//  BindViewController.h
//  reservation
//
//  Created by iOS开发 on 15/6/16.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"

@interface BindViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSDictionary *type;
@property (strong, nonatomic) NSString *verifyNum;
@property (strong, nonatomic) NSString *huiguanNum;
@property (strong, nonatomic) NSString *verifyTypeNum;
@property (strong, nonatomic) IBOutlet UIFolderTableView *tableView;
-(void)subCateBtnAction:(UIButton *)btn;
@end

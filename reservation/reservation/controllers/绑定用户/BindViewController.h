//
//  BindViewController.h
//  reservation
//
//  Created by 王晓娜 on 15/6/16.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"

@interface BindViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) NSDictionary *type;
@property (strong, nonatomic) NSString *verifyNum;
@property (strong, nonatomic) NSString *huiguanNum;
@property (strong, nonatomic) NSString *verifyTypeNum;
@property (strong, nonatomic) IBOutlet UIFolderTableView *tableView;
-(void)subCateBtnAction:(UIButton *)btn;
@end

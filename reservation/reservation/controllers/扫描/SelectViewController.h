//
//  SelectViewController.h
//  reservation
//
//  Created by iOS开发 on 15/6/17.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectViewController : UIViewController
@property(nonatomic) BOOL type_n;
@property (strong,nonatomic) NSString *string_api;
@property(strong,nonatomic) NSMutableArray *tableViewList;

@end

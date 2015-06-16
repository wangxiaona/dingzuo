//
//  FirstViewController.h
//  reservation
//
//  Created by 王晓娜 on 15/6/15.
//  Copyright (c) 2015年 wangxiaona. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (strong, nonatomic) IBOutlet UIView *scanView;
@property(strong,nonatomic)NSTimer *timer;
- (IBAction)cancelButtonPressed:(id)sender;

@end

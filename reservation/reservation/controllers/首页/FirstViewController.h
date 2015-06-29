//
//  FirstViewController.h
//  reservation
//
//  Created by iOS开发 on 15/6/15.
//  Copyright (c) 2015年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *pointView;
@property (strong, nonatomic) IBOutlet UIView *scanView;
@property(strong,nonatomic)NSTimer *timer;
- (IBAction)cancelButtonPressed:(id)sender;

@end

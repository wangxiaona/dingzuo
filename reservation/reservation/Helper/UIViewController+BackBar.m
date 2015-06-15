//
//  UIViewController+BackBar.m
//  EXTW
//
//  Created by wangxiang on 10/24/14.
//  Copyright (c) 2014 wangxiang. All rights reserved.
//

#import "UIViewController+BackBar.h"

@implementation UIViewController (BackBar)
-(void)setCustomizeBackBar
{
    //返回buttonitem
    
    self.navigationItem.leftBarButtonItem = [self backButton];
    
}

-(UIBarButtonItem *)backButton
{
    UIImage *normalImage = [UIImage imageNamed:@"back_arrow"];
    CGRect buttonFrame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    
    [button setImage:normalImage forState:UIControlStateNormal];
    UIBarButtonItem *item= [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

-(void)backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
